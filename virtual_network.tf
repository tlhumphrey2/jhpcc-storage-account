#############
##vnet##
#############
/*
module "virtual_network" {
  #source  = "tfe.lnrisk.io/Infrastructure/virtual-network/azurerm"
  source = "git@github.com:Azure-Terraform/terraform-azurerm-virtual-network.git?ref=v6.0.0"

  naming_rules        = module.naming.yaml
  resource_group_name = module.resource_group.name
  #resource_group_name = data.azurerm_kubernetes_cluster.wipe-play-aks.name
  location            = module.metadata.location
  names               = module.metadata.names
  tags                = local.all_tags

  enforce_subnet_names = false

  #address_space = [var.cidr_block]
  address_space = ["10.1.0.0/22"]
  #dns_servers   = [local.firewall_ip]

  #route_tables = {
  # default = local.route_table
  #}
}
#========================================================================
# The following instead of using the commented-out aks-hpcc subnet, above.
resource "azurerm_subnet" "aks-hpcc" {
  name                 = "aks-hpcc"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.virtual_network.vnet.name
  #address_prefixes     = [var.cidr_block_app]
  address_prefixes     = ["10.1.0.0/24"]
  service_endpoints = ["Microsoft.Storage", "Microsoft.ContainerRegistry"]
  #private_endpoint_network_policies_enabled = true
  #private_link_service_network_policies_enabled = true
}

resource "azurerm_route_table" "aks-hpcc-subnet-routes" {
  name                          = "routes-of-aks-hpcc-subnet"
  location                      = module.metadata.location
  resource_group_name           = module.resource_group.name
  disable_bgp_route_propagation = true

  route {
      address_prefix         = "0.0.0.0/0"
      name                   = "internet"
      next_hop_type          = "Internet"
  }

  route {
      #address_prefix         = "10.1.0.0/21"
      address_prefix         = "10.1.0.0/22"
      name                   = "local-vnet"
      next_hop_type          = "VnetLocal"
  }

  #route {
  #   address_prefix         = "10.0.0.0/8"
  #   name                   = "internal-1"
  #   next_hop_in_ip_address = "10.241.2.68"
  #   next_hop_type          = "VirtualAppliance"
  #}

  #route {
  #   address_prefix         = "100.65.0.0/24"
  #   name                   = "aks-bootstrap-34700672-vmss000000____100650024"
  #   next_hop_in_ip_address = "10.1.2.4"
  #   next_hop_type          = "VirtualAppliance"
  #}

  #route {
  #   address_prefix         = "172.16.0.0/12"
  #   name                   = "internal-2"
  #   next_hop_in_ip_address = "10.241.2.68"
  #   next_hop_type          = "VirtualAppliance"
  #}

  #route {
  #   address_prefix         = "192.168.0.0/16"
  #   name                   = "internal-3"
  #   next_hop_in_ip_address = "10.241.2.68"
  #   next_hop_type          = "VirtualAppliance"
  #}
}
*/
#========================================================================