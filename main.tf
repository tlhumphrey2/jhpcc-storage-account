data "azurerm_subscription" "current" {
}

module "subscription" {
  source  = "github.com/Azure-Terraform/terraform-azurerm-subscription-data.git"
  #subscription_id = "49219efc-701f-4c7e-a2ac-c600308a69e3"
  subscription_id = data.azurerm_subscription.current.subscription_id
}

module "naming" {
  #source = "github.com/Azure-Terraform/example-naming-template.git?ref=v1.0.0"
  source = "git@github.com:LexisNexis-RBA/terraform-azurerm-naming.git?ref=v1.0.81"
}

resource "random_string" "random" {
  length  = 12
  upper   = false
  number  = false
  special = false
}

module "metadata" {
  #source = "github.com/Azure-Terraform/terraform-azurerm-metadata.git?ref=v1.5.0"
  source = "git@github.com:Azure-Terraform/terraform-azurerm-metadata.git?ref=v1.5.1"

  naming_rules = module.naming.yaml

  market              = "us"
  project             = "hpccsystems"
  location            = "eastus"
  environment         = "sandbox"
  #product_name        = "hpccsystems"
  product_name        = format("tlhsto%s", random_string.random.result)
  business_unit       = "iog"
  product_group       = "hpccsystems"
  #subscription_id     = data.azurerm_subscription.current.subscription_id
  subscription_id     = module.subscription.output.subscription_id
  subscription_type   = "dev"
  resource_group_type = "app"
}

module "resource_group" {
  source   = "git@github.com:Azure-Terraform/terraform-azurerm-resource-group.git?ref=v2.1.0"
  location = module.metadata.location
  names    = module.metadata.names
  tags     = local.all_tags
}

# ========================The following is used only my stand-alone storage ========================
module "deploy_storage" {
  source = "./smodule/storage"

  tags = local.all_tags
  resource_group_name = module.resource_group.name
  location = module.metadata.location
  environment = "dev"

  namespace = {
    name = "hpcc"
    labels = {
      name = "hpcc"
    }
  }

  admin_services_storage_account_settings = {
    replication_type     = "ZRS"
    authorized_ip_ranges = merge(var.storage_account_authorized_ip_ranges, { my_ip = data.http.my_ip.response_body })
    delete_protection    = false
    #subnet_ids = { "aks-hpcc" = azurerm_subnet.aks-hpcc.id }
    subnet_ids = merge({
      "aks-hpcc" = azurerm_subnet.aks-hpcc.id # changed to this when aks created in separate TF
    }, var.azure_admin_subnets)
  }

  data_storage_config = {
   internal = {
     blob_nfs = {
       data_plane_count = var.hpcc_data_plane_count
       storage_account_settings = {
         replication_type     = "ZRS"
         authorized_ip_ranges = merge(var.storage_account_authorized_ip_ranges, { my_ip = data.http.my_ip.response_body })
         delete_protection    = false
         #subnet_ids = { "aks-hpcc" = azurerm_subnet.aks-hpcc.id }
         subnet_ids = merge({
           "aks-hpcc" = azurerm_subnet.aks-hpcc.id # changed to this when aks created in separate TF
         }, var.azure_admin_subnets)
       }
     }
     hpc_cache = null
   }
   external = null
  }

  admin_services_storage = {
    dali = {
      size = 200
      type = "azurefiles"
    }
    debug = {
      size = 100
      type = "blobnfs"
    }
    dll = {
      size = 1000
      type = "blobnfs"
    }
    lz = {
      size = 1000
      type = "blobnfs"
    }
    sasha = {
      size = 10000
      type = "blobnfs"
    }
  }
}