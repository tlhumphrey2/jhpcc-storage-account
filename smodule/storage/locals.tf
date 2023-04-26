locals {
  azurefiles_admin_storage_enabled = contains([for storage in var.admin_services_storage : storage.type], "azurefiles")
  blobnfs_admin_storage_enabled    = contains([for storage in var.admin_services_storage : storage.type], "blobnfs")

  internal_data_config = var.data_storage_config.internal == null ? false : true
  external_data_config = var.data_storage_config.external == null ? false : true

  create_data_storage = (local.internal_data_config ? (var.data_storage_config.internal.blob_nfs == null ? false : true) : false)
  create_data_cache   = (local.internal_data_config ? (var.data_storage_config.internal.hpc_cache == null ? false : true) : false)

  external_data_storage = (local.external_data_config ? (var.data_storage_config.external.blob_nfs == null ? false : true) : false)

  external_data_cache   = (local.external_data_config ? (var.data_storage_config.external.hpc_cache == null ? false : true) : false)

  external_hpcc_data    = (local.external_data_config ? (var.data_storage_config.external.hpcc == null ? false : true) : false)

  azure_files_pv_protocol = var.environment == "dev" ? "nfs" : null

  storage_config = {
    blob_nfs = (local.create_data_storage ? module.data_storage.0.data_planes : (
      local.external_data_storage ? var.data_storage_config.external.blob_nfs : null)
    )
    hpc_cache = (local.create_data_cache ? module.data_cache.0.data_planes.internal : (
      local.external_data_cache ? var.data_storage_config.external.hpc_cache : null)
    )
    hpcc = local.external_hpcc_data ? var.data_storage_config.external.hpcc : []
  }

  services_storage_config = [
    {
      category       = "dali"
      container_name = "hpcc-dali"
      path           = "dalistorage"
      plane_name     = "dali"
      size           = "${var.admin_services_storage.dali.size}G"
      storage_type   = var.admin_services_storage.dali.type
    },
    {
      category       = "debug"
      container_name = "hpcc-debug"
      path           = "debug"
      plane_name     = "debug"
      size           = "${var.admin_services_storage.debug.size}G"
      storage_type   = var.admin_services_storage.debug.type
    },
    {
      category       = "dll"
      container_name = "hpcc-dll"
      path           = "queries"
      plane_name     = "dll"
      size           = "${var.admin_services_storage.dll.size}G"
      storage_type   = var.admin_services_storage.dll.type
    },
    {
      category       = "lz"
      container_name = "hpcc-mydropzone"
      path           = "mydropzone"
      plane_name     = "mydropzone"
      size           = "${var.admin_services_storage.lz.size}G"
      storage_type   = var.admin_services_storage.lz.type
    },
    {
      category       = "sasha"
      container_name = "hpcc-sasha"
      path           = "sashastorage"
      plane_name     = "sasha"
      size           = "${var.admin_services_storage.sasha.size}G"
      storage_type   = var.admin_services_storage.sasha.type
    }
  ]

  azurefiles_services_storage = { for config in local.services_storage_config :
    config.plane_name => {
      category        = config.category
      container_name  = config.container_name
      path            = config.path
      resource_group  = var.resource_group_name
      size            = config.size
      storage_account = azurerm_storage_account.azurefiles_admin_services.0.name
      protocol        = local.azure_files_pv_protocol
    } if config.storage_type == "azurefiles"
  }

  blob_nfs_services_storage = { for config in local.services_storage_config :
    config.plane_name => {
      category        = config.category
      container_name  = config.container_name
      path            = config.path
      resource_group  = var.resource_group_name
      size            = config.size
      storage_account = azurerm_storage_account.blob_nfs_admin_services.0.name
    } if config.storage_type == "blobnfs"
  }

}
