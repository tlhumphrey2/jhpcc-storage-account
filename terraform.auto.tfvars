#azure_admin_subnets = {"tfe_prod"="/subscriptions/debc4966-2669-4fa7-9bd9-c4cdb08aed9f/resourceGroups/app-tfe-prod-useast2/providers/Microsoft.Network/virtualNetworks/core-production-useast2-vnet/subnets/iaas-public"}
#azure_admin_subnets = {"myvm_default"="/subscriptions/49219efc-701f-4c7e-a2ac-c600308a69e3/resourceGroups/rg-tlh-dev-linux-vm-eastus2/providers/Microsoft.Network/virtualNetworks/rg-tlh-dev-linux-vm-eastus2-vnet/subnets/default", "myvm_fwsubnet" = "/subscriptions/49219efc-701f-4c7e-a2ac-c600308a69e3/resourceGroups/rg-tlh-dev-linux-vm-eastus2/providers/Microsoft.Network/virtualNetworks/rg-tlh-dev-linux-vm-eastus2-vnet/subnets/AzureFirewallSubnet"}
azure_admin_subnets = {"myvm_default"="/subscriptions/49219efc-701f-4c7e-a2ac-c600308a69e3/resourceGroups/rg-tlh-dev-linux-vm-eastus2/providers/Microsoft.Network/virtualNetworks/rg-tlh-dev-linux-vm-eastus2-vnet/subnets/default"}

storage_account_authorized_ip_ranges = {
  "alpharetta" = "66.241.32.0/19"
  "boca"       = "209.243.48.0/20"
  "tfe"        = "52.177.80.30"
  "myvm"       = "20.96.186.106"
  #"world"      = "0.0.0.0/0"
  "tfe2"       = "20.69.219.180"
}

hpcc_data_plane_count = 2
