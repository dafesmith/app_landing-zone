#Import cert to key vault from pfx file
resource "azurerm_key_vault_certificate" "this" {
  key_vault_id = var.target_key_vault_id
  name         = var.cert_entry_name

  certificate {
    contents = filebase64(var.source_pfx_filename)
    password = var.source_pfx_password
  }
}