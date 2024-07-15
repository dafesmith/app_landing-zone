output "vnetid" {
  value = data.azurerm_virtual_network.virtualnetwork.id
}

output "vault_uri" {
  value = data.azurerm_key_vault.keyvault.vault_uri
}

output "admin-password" {
  value = random_password.adminpassword.result
}


output "account_id" {
  value = data.azurerm_client_config.current.client_id
}