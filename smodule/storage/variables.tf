variable "location" {
  description = "Azure region in which to create resources."
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace where resources will be created."
  type = object({
    name   = string
    labels = map(string)
  })
  default = {
    name = "hpcc"
    labels = {
      name = "hpcc"
    }
  }
}

variable "environment" {
  description = "Environment HPCC is being deployed to."
  type        = string
  default     = "dev"
}

variable "resource_group_name" {
  description = "The name of the resource group to deploy resources."
  type        = string
}

variable "admin_services_storage" {
  description = "PV sizes for admin service planes in gigabytes (storage billed only as consumed)."
  type = object({
    dali = object({
      size = number
      type = string
    })
    debug = object({
      size = number
      type = string
    })
    dll = object({
      size = number
      type = string
    })
    lz = object({
      size = number
      type = string
    })
    sasha = object({
      size = number
      type = string
    })
  })
  default = {
    dali = {
      size = 100
      type = "azurefiles"
    }
    debug = {
      size = 100
      type = "blobnfs"
    }
    dll = {
      size = 100
      type = "blobnfs"
    }
    lz = {
      size = 100
      type = "blobnfs"
    }
    sasha = {
      size = 100
      type = "blobnfs"
    }
  }

  validation {
    condition     = length([for k, v in var.admin_services_storage : v.type if !contains(["azurefiles", "blobnfs"], v.type)]) == 0
    error_message = "The type must be either \"azurefiles\" or \"blobnfs\"."
  }

  validation {
    condition     = length([for k, v in var.admin_services_storage : v.size if v.type == "azurefiles" && v.size < 100]) == 0
    error_message = "Size must be at least 100 for \"azurefiles\" type."
  }
}

variable "admin_services_storage_account_settings" {
  description = "Settings for admin services storage account."
  type = object({
    authorized_ip_ranges                 = map(string)
    delete_protection                    = bool
    replication_type                     = string
    subnet_ids                           = map(string)
    blob_soft_delete_retention_days      = optional(number)
    container_soft_delete_retention_days = optional(number)
    file_share_retention_days            = optional(number)
  })
  default = {
    authorized_ip_ranges                 = {}
    delete_protection                    = false
    replication_type                     = "ZRS"
    subnet_ids                           = {}
    blob_soft_delete_retention_days      = 7
    container_soft_delete_retention_days = 7
    file_share_retention_days            = 7
  }
}

variable "data_storage_config" {
  description = "Data plane config for HPCC."
  type = object({
    internal = object({
      blob_nfs = object({
        data_plane_count = number
        storage_account_settings = object({
          authorized_ip_ranges                 = map(string)
          delete_protection                    = bool
          replication_type                     = string
          subnet_ids                           = map(string)
          blob_soft_delete_retention_days      = optional(number)
          container_soft_delete_retention_days = optional(number)
        })
      })
      hpc_cache = object({
        cache_update_frequency = string
        dns = object({
          zone_name                = string
          zone_resource_group_name = string
        })
        resource_provider_object_id = string
        size                        = string
        storage_account_data_planes = list(object({
          container_id         = string
          container_name       = string
          id                   = number
          resource_group_name  = string
          storage_account_id   = string
          storage_account_name = string
        }))
        subnet_id = string
      })
    })
    external = object({
      blob_nfs = list(object({
        container_id         = string
        container_name       = string
        id                   = string
        resource_group_name  = string
        storage_account_id   = string
        storage_account_name = string
      }))
      hpc_cache = list(object({
        id     = string
        path   = string
        server = string
      }))
      hpcc = list(object({
        name = string
        planes = list(object({
          local  = string
          remote = string
        }))
        service = string
      }))
    })
  })
  default = {
    internal = {
      blob_nfs = {
        data_plane_count = 1
        storage_account_settings = {
          authorized_ip_ranges                 = {}
          delete_protection                    = false
          replication_type                     = "ZRS"
          subnet_ids                           = {}
          blob_soft_delete_retention_days      = 7
          container_soft_delete_retention_days = 7
        }
      }
      hpc_cache = null
    }
    external = null
  }

  validation {
    condition = (var.data_storage_config.internal == null ? true :
      var.data_storage_config.internal.hpc_cache == null ? true :
    contains(["never", "30s", "3h"], var.data_storage_config.internal.hpc_cache.cache_update_frequency))
    error_message = "HPC Cache update frequency must be \"never\", \"30s\" or \"3h\"."
  }
}

variable "tags" {
  description = "Tags to be applied to Azure resources."
  type        = map(string)
  default     = {}
}
