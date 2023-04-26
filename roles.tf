/*data "azurerm_virtual_machine" "myvm" {
  name = "tlh-dev-linux-vm"
  resource_group_name = "rg-tlh-dev-linux-vm-eastus2"
}*/

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
#==================================================================================
/*resource "azurerm_role_definition" "role_definition_storage"{
  name = "role_definition-for-hpccaulayafsvc"
  #name = format( "%s-%s-%s-roledefinition", module.metadata.market, module.metadata.product_group, module.metadata.environment)
  scope = "/subscriptions/49219efc-701f-4c7e-a2ac-c600308a69e3"
  #scope = "/subscriptions/49219efc-701f-4c7e-a2ac-c600308a69e3/resourceGroups/app-tlhmjnkyrwfsfvb-sandbox-eastus"
  #scope = azurerm_storage_account.storage-account.id

  permissions {    
    actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/write",
      "Microsoft.Storage/storageAccounts/blobServices/containers/delete"
    ]
    not_actions = []
    data_actions = [ 
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/delete", 
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read", 
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write", 
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/move/action", 
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action" 
    ]
  }

}*/

/*resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  resource_group_name   = var.resource_group_name
  location              = module.metadata.location
  #resource_group_name   = module.resource_group.name
  #location              = module.resource_group.location
  name                  = "tlh-hpcc-uai-4"  
}*/        

#======================================================================================