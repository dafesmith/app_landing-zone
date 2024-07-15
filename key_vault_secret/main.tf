resource "azurerm_key_vault_secret" "this" {
  key_vault_id = var.target_key_vault_id
  name         = var.secret_name
  value        = var.secret_value
}