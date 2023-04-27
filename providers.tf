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
}

provider "azuread" {}