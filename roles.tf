/*data "azurerm_virtual_machine" "myvm" {
  name = "tlh-dev-linux-vm"
  resource_group_name = "rg-tlh-dev-linux-vm-eastus2"
}*/

/*
resource "azurerm_user_assigned_identity" "my-uaid" {
  resource_group_name   = module.resource_group.name
  location              = module.metadata.location
  name                  = "tlh-hpcc-uai-5"  
}        

resource "azurerm_role_assignment" "owner" {
  scope = "/subscriptions/49219efc-701f-4c7e-a2ac-c600308a69e3"
  role_definition_name = "Owner"
  #principal_id       = data.azurerm_virtual_machine.myvm.identity[0].principal_id
  principal_id       = azurerm_user_assigned_identity.my-uaid.principal_id
}

resource "azurerm_role_assignment" "contributor" {
  scope = "/subscriptions/49219efc-701f-4c7e-a2ac-c600308a69e3"
  role_definition_name = "Contributor"
  #principal_id       = data.azurerm_virtual_machine.myvm.identity[0].principal_id
  principal_id       = azurerm_user_assigned_identity.my-uaid.principal_id

  depends_on = [azurerm_role_assignment.owner]
}

resource "azurerm_role_assignment" "storage-account-contributor" {
  scope = "/subscriptions/49219efc-701f-4c7e-a2ac-c600308a69e3"
  role_definition_name = "Storage Account Contributor"
  #principal_id       = data.azurerm_virtual_machine.myvm.identity[0].principal_id
  principal_id       = azurerm_user_assigned_identity.my-uaid.principal_id

  depends_on = [azurerm_role_assignment.owner]
}

resource "azurerm_role_assignment" "storage-blob-data-owner" {
  scope = "/subscriptions/49219efc-701f-4c7e-a2ac-c600308a69e3"
  role_definition_name = "Storage Blob Data Owner"
  #principal_id       = data.azurerm_virtual_machine.myvm.identity[0].principal_id
  principal_id       = azurerm_user_assigned_identity.my-uaid.principal_id

  depends_on = [azurerm_role_assignment.owner]
}

resource "azurerm_role_assignment" "storage-blob-data-contributor" {
  scope = "/subscriptions/49219efc-701f-4c7e-a2ac-c600308a69e3"
  role_definition_name = "Storage Blob Data Contributor"
  #principal_id       = data.azurerm_virtual_machine.myvm.identity[0].principal_id
  principal_id       = azurerm_user_assigned_identity.my-uaid.principal_id

  depends_on = [azurerm_role_assignment.owner]
}

resource "azurerm_role_assignment" "storage-blob-data-reader" {
  scope = "/subscriptions/49219efc-701f-4c7e-a2ac-c600308a69e3"
  role_definition_name = "Storage Blob Data Reader"
  #principal_id       = data.azurerm_virtual_machine.myvm.identity[0].principal_id
  principal_id       = azurerm_user_assigned_identity.my-uaid.principal_id

  depends_on = [azurerm_role_assignment.owner]
}
*/