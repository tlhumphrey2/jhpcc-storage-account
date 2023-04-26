#aad_group_id = "102207e4-ae85-4d12-9a4f-b79330540440"

#azure_admin_subnets = {"tfe_prod"="/subscriptions/debc4966-2669-4fa7-9bd9-c4cdb08aed9f/resourceGroups/app-tfe-prod-useast2/providers/Microsoft.Network/virtualNetworks/core-production-useast2-vnet/subnets/iaas-public"}
# This tfvars file is for the hpcc cluster
node_tuning_containers = null

hpcc_data_plane_count = 2 

# Naming

environment = "dev" # Lifecycle environment - dev/nonprod/prod
productname = "hpccsystems"

jfrog_registry = {
  image_root = "useast.jfrog.lexisnexisrisk.com/glb-docker-virtual",
  image_name = "platform-core-ln",
  version    = "8.10.24"
}

jfrog_auth = {
  username = "humphrtl@risk.regn.net",
  password = "cmVmdGtuOjAxOjE3MDg2OTU4ODI6VEl2VzJaVWNRdUdVR3A4YUU0ekdHWXNmdUFT"
}

# Network
#cidr_block         = "10.143.31.0/24"
#cidr_block_app     = "10.143.31.0/25"
#cidr_block_acr     = "10.143.32.0/25"
/*
cidr_block         = "10.0.0.0/24"
cidr_block_app     = "10.0.1.0/25"
cidr_block_storage = "10.0.2.0/26"
cidr_block_acr     = "10.0.4.0/26"
*/
cidr_block         = "10.1.0.0/21"
cidr_block_acr     = "10.1.0.0/25"
cidr_block_app     = "10.1.2.0/24"

#cidr_block         = "10.0.0.0/24"
#cidr_block_app     = "10.0.0.0/25"
#cidr_block_acr     = "10.0.2.0/25"

rbac_bindings = {
  cluster_admin_users = {
    "humphrtl@risk.regn.net" = "35cbdc79-7ef5-4d2c-9b59-61ec21d76aa9"
  }
  cluster_view_users  = {}
  cluster_view_groups = []
}

#default_connection_info = null
api_server_authorized_ip_ranges = {
  "alpharetta" = "66.241.32.0/19"
  "boca"       = "209.243.48.0/20"
  "tfe"        = "52.177.80.30"
}
storage_account_authorized_ip_ranges = {
  "alpharetta" = "66.241.32.0/19"
  "boca"       = "209.243.48.0/20"
  "tfe"        = "52.177.80.30"
  "myvm"       = "20.96.186.106"
}
