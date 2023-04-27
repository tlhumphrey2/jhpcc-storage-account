# ========================The following is used only my stand-alone storage ========================
module "deploy_storage" {
  source = "./smodule/storage"

  tags = local.all_tags
  resource_group_name = var.resource_group_name
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
    #subnet_ids = { "aks-hpcc" = data.azurerm_subnet.aks-hpcc.id }
    subnet_ids = merge({
      "aks-hpcc" = data.azurerm_subnet.aks-hpcc.id # changed to this when aks created in separate TF
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
         #subnet_ids = { "aks-hpcc" = data.azurerm_subnet.aks-hpcc.id }
         subnet_ids = merge({
           "aks-hpcc" = data.azurerm_subnet.aks-hpcc.id # changed to this when aks created in separate TF
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