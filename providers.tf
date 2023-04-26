terraform {
  required_version = "~>1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.52.0"
      #version = "~> 3.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.19"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.11"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.7.2"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.21"
    }
    shell = {
      source  = "scottwinkler/shell"
      version = "~> 1.7"
    }
  }
}

provider "azurerm" {
  features {}
  use_msi = true
  storage_use_azuread = true
  subscription_id = "49219efc-701f-4c7e-a2ac-c600308a69e3"
  #subscription_id = module.subscription.output.subscription_id
}

provider "azuread" {}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
  username               = data.azurerm_kubernetes_cluster.aks.kube_admin_config.0.username
  password               = data.azurerm_kubernetes_cluster.aks.kube_admin_config.0.password

  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config.0.client_key)
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config.0.client_certificate)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config.0.cluster_ca_certificate)
  #host                   = module.aks.cluster_endpoint
  #cluster_ca_certificate = base64decode(module.aks.cluster_certificate_authority_data)

  /*exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args        = ["get-token", "--server-id", "6dae42f8-4368-4678-94ff-3960e28e3630", "--login", "azurecli"]
    env         = local.azure_auth_env
  }*/
}

provider "kubectl" {
  host                   = data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
  username               = data.azurerm_kubernetes_cluster.aks.kube_admin_config.0.username
  password               = data.azurerm_kubernetes_cluster.aks.kube_admin_config.0.password

  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config.0.client_key)
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config.0.client_certificate)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config.0.cluster_ca_certificate)
  #host                   = module.aks.cluster_endpoint
  #cluster_ca_certificate = base64decode(module.aks.cluster_certificate_authority_data)
  load_config_file       = false
  apply_retry_count      = 6

  /*exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args        = ["get-token", "--server-id", "6dae42f8-4368-4678-94ff-3960e28e3630", "--login", "azurecli"]
    env         = local.azure_auth_env
  }*/
}

provider "helm" {
  kubernetes {
    host = data.azurerm_kubernetes_cluster.aks.fqdn
    #host = module.aks.cluster_fqdn
    config_path = "~/.kube/config"

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "kubelogin"
      args        = ["get-token", "--server-id", "6dae42f8-4368-4678-94ff-3960e28e3630", "--login", "azurecli"]
      env         = local.azure_auth_env
    }
  }
}

provider "shell" {
  sensitive_environment = local.azure_auth_env
}