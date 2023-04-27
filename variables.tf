variable "resource_group_name" {
  type  = string
} 

variable "virtual_network_name" {
  description = "Added virtual network name when aks was created in different terraform. Will be created using '-var' on command line."
  type        = string
}

variable "subnet_name" {
  description = "Added aks subnet name when aks was created in different terraform. Will be created using '-var' on command line."
  type        = string
}

variable "azure_admin_subnets" {
  type  = any
  default = {"tfe_prod"="/subscriptions/debc4966-2669-4fa7-9bd9-c4cdb08aed9f/resourceGroups/app-tfe-prod-useast2/providers/Microsoft.Network/virtualNetworks/core-production-useast2-vnet/subnets/iaas-public"}
} 

variable "storage_account_authorized_ip_ranges" {
  description = "Map of authorized CIDRs / IPs"
  type        = map(string)
}

variable "hpcc_data_plane_count" {
  type = number
}
