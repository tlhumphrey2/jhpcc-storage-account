variable "resource_group_name" {
  description = "Added resource group name when aks was created in different terraform. Will be created using '-var' on command line."
  type        = string
}

variable "virtual_network_name" {
  description = "Added virtual network name when aks was created in different terraform. Will be created using '-var' on command line."
  type        = string
}

variable "aks_subnet_name" {
  description = "Added aks subnet name when aks was created in different terraform. Will be created using '-var' on command line."
  type        = string
}

variable "node_tuning_containers" {
  description = "URIs for containers to be used by node tuning submodule."
  type = object({
    busybox = string
    debian  = string
  })
}

variable "aad_group_id" {
  description = "Terraform variable - Azure Active Directory Group ID that contains the temporary Service Principal"
  type        = string
  default     = "102207e4-ae85-4d12-9a4f-b79330540440"
}

variable "rbac_bindings" {
  description = "User and groups to configure in Kubernetes ClusterRoleBindings; for Azure AD these are the IDs."
  type        = any
  default = {
    cluster_admin_users = {}
    cluster_view_users  = {}
    cluster_view_groups = []
  }
}

variable "hpcc_data_plane_count" {
  type = number
}

variable "environment" {
  type = string
}

variable "productname" {
  description = "Product Name from Naming module"
  type        = string
}

variable "azure_admin_subnets" {
  type  = any
  default = {"tfe_prod"="/subscriptions/debc4966-2669-4fa7-9bd9-c4cdb08aed9f/resourceGroups/app-tfe-prod-useast2/providers/Microsoft.Network/virtualNetworks/core-production-useast2-vnet/subnets/iaas-public"}
}

variable "sku_tier" {
  type    = string
  default = "Free"
}

variable "firewall_ip" {
  type    = string
  default = "10.241.2.68"
}

variable "expressroute_id" {
  type    = string
  default = "/subscriptions/977f34c1-5bba-493d-bba9-815edf8f5fc4/resourceGroups/shared-expressroute-prod-eastus-businesssvc-nonprod/providers/Microsoft.Network/virtualNetworks/networks-production-eastus-vnet"
}

variable "cidr_block" {
  type = string
}

variable "cidr_block_acr" {
  type = string
}

variable "cidr_block_app" {
  type = string
}

variable "create_network_security_group" {
  description = "Create/associate network security group"
  type        = bool
  default     = true
}

variable "configure_nsg_rules" {
  description = "Configure network security group rules"
  type        = bool
  default     = true # false
}

variable "allow_internet_outbound" {
  description = "allow outbound traffic to internet"
  type        = bool
  default     = true
}

variable "allow_lb_inbound" {
  description = "allow inbound traffic from Azure Load Balancer"
  type        = bool
  default     = true
}

variable "allow_vnet_inbound" {
  description = "allow all inbound from virtual network"
  type        = bool
  default     = true
}

variable "allow_vnet_outbound" {
  description = "allow all outbound from virtual network"
  type        = bool
  default     = true
}

variable "enforce_private_link_endpoint_network_policies" {
  description = "Enforce private link endpoint network policies?"
  type        = bool
  default     = true
}

variable "api_server_authorized_ip_ranges" {
  description = "Map of authorized CIDRs / IPs"
  type        = map(string)
}

variable "storage_account_authorized_ip_ranges" {
  description = "Map of authorized CIDRs / IPs"
  type        = map(string)
}

variable "hpcc_container" {
  description = "HPCC container registry info."
  type = object({
    image_name = string
    image_root = string
    version    = string
  })
  sensitive = true
  default   = null
}

variable "hpcc_container_registry_auth" {
  description = "Registry authentication for HPCC containers."
  type = object({
    password = string
    username = string
  })
  default   = null
  sensitive = true
}

variable "tfe_prod_subnet_id" {
  description = "Terraform enterprise Subnet id"
  type        = string
  default     = "/subscriptions/debc4966-2669-4fa7-9bd9-c4cdb08aed9f/resourceGroups/app-tfe-prod-useast2/providers/Microsoft.Network/virtualNetworks/core-production-useast2-vnet/subnets/iaas-public"

}

# JFrog
variable "jfrog_registry" {
  description = "values to set as secrets for JFrog repo access"
  type = object({
    image_root = string
    image_name = string
    version    = string
  })
  sensitive = true
}

variable "jfrog_auth" {
  description = "values to set as secrets for JFrog repo access"
  type = object({
    username = string
    password = string # API Token
  })
  sensitive = true
}

