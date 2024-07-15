resource "azurerm_role_assignment" "this" {
  scope                = var.resource_id
  role_definition_name = var.role_definition_name # example "Key Vault Administrator"
  principal_id         = var.principal_id         # user object id "4c85edcb-c7bb-4d83-833d-de8c9b3fe96f"
}