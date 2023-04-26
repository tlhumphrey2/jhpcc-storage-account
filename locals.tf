locals {
 #azure_auth_env = {
 #  #AZURE_TENANT_ID       = "9274ee3f-9425-4109-a27f-9fb15c10675d"
 #  AZURE_TENANT_ID       = "bc877e61-f6cf-4461-accd-0565fa4ca357"
 #}
  azure_auth_env = {
    AZURE_TENANT_ID = data.azurerm_client_config.current.tenant_id
    AZURE_SUBSCRIPTION_ID = data.azurerm_client_config.current.subscription_id
  }

  all_tags     = merge(module.metadata.tags, {"owner": "Timothy L Humphrey", "owner_email": "timothy.humphrey@lexisnexisrisk.com" })

  #cluster_name = "us-securityeng-dev-hpcc-aks-1"
  #cluster_name = "tlh-us-hpccsystems-dev-hpcc-aks-1"
  #cluster_name = "hpcc-aks-1"
  #cluster_name = "app-aks-1"
  cluster_name = "tlh-wipe-play-hpcc-aks-2"

  account_code = "us-hpccsystems-dev"

  #cluster_version    = "1.23"
  cluster_version    = "1.24"
  #cluster_version    = "1.22"
  #cluster_version    = "1.21"

  cluster_admin_users = {
    "humphrtl@risk.regn.net" = "35cbdc79-7ef5-4d2c-9b59-61ec21d76aa9"
  }

  #dns_resource_group = "app-dns-prod-eastus2"
  dns_resource_group = "tlh-dns-dev-eastus"

  #internal_domain = "us-securityeng-dev.azure.lnrsg.io"
  #internal_domain = "us-hpccsystems-dev.azure.lnrsg.io"
  # NOTE: I had to create the RG and dnszone in azure portal
  internal_domain = "tlh-private-us-hpccsystems-dev.azure.lnrsg.io"

  cluster_name_short = trimprefix(local.cluster_name, "${local.account_code}-")

  acr_trusted_ips = {
    tfe   = "20.69.219.180/32"
    boca  = "209.243.48.0/20"
    india = "103.231.79.16/28"
    ntt   = "83.231.190.16/28"
    ntt2  = "83.231.235.0/24"
    uk    = "89.149.148.0/24" # London VPN
    ala   = "66.241.32.0/19"  # Alpharetta VPN
    ngd   = "77.67.50.160/28"
    vpn   = "52.177.80.30/32" # includes vault
  }

  smtp_host = "appmail-test.risk.regn.net"
  smtp_from = "foo@bar.com"

  rbac_bindings = { 
    cluster_admin_users = local.cluster_admin_users
    cluster_view_users  = {}
    cluster_view_groups = []
  }

  node_groups = {
    workers = {
      node_type_version = "v1"
      node_size         = "large"
      max_capacity      = 18
      labels = {
        "lnrs.io/tier" = "standard"
      }
    }
  }

  /*node_groups = {
    thorpool = {
      node_type         = "gpd"
      node_type_version = "v1"
      node_size         = "8xlarge"
      max_capacity      = 309
      os_config = {
        sysctl = {
          net_ipv4_tcp_keepalive_time = 200
        }
      }
      labels = {
        "lnrs.io/tier" = "standard"
        "workload"     = "thorpool"
      }
    },

    spraypool = {
      node_type         = "gp"
      node_type_version = "v1"
      node_size         = "xlarge"
      min_capacity      = 3
      max_capacity      = 3
      os_config = {
        sysctl = {
          net_ipv4_tcp_keepalive_time = 200
        }
      }
      single_group = false
      labels = {
        "lnrs.io/tier"  = "standard"
        "workload"      = "spraypool"
        "spray-service" = "spraypool"
      }
    },
    servpool = {
      node_type         = "gpd"
      node_type_version = "v1"
      node_size         = "4xlarge"
      max_capacity      = 9
      os_config = {
        sysctl = {
          net_ipv4_tcp_keepalive_time = 200
        }
      }
      labels = {
        "lnrs.io/tier" = "standard"
        "workload"     = "servpool"
      }
    }
  }*/

  grafana_admin_password = random_string.random.result
  internal_ips = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  firewall_ip  = "10.241.2.68"

  routes = merge(
    {
      internet = {
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "Internet"
      }
      local-vnet = {
        address_prefix = var.cidr_block
        next_hop_type  = "VnetLocal"
      }
    },
    { for ip in local.internal_ips :
      format("internal-%s", index(local.internal_ips, ip) + 1) => {
        address_prefix         = ip
        next_hop_type          = "VirtualAppliance"
        next_hop_in_ip_address = local.firewall_ip
      }
    }
  )

  route_table = {
    routes                        = local.routes
    disable_bgp_route_propagation = true
    use_inline_routes             = false
  }

  alert_manager_recievers = []
  alert_manager_routes    = []
}