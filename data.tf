data "azurerm_client_config" "current" {}

data "azuread_group" "subscription_owner" {
  display_name = "ris-azr-group-${data.azurerm_subscription.current.display_name}-owner"
}

data "http" "my_ip" {
  url = "https://ifconfig.me"
}
