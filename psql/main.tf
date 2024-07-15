data "azurerm_subnet" "subnet" {
  name                 = var.postgresql_subnet_name
  virtual_network_name = var.postgresql_vnet_name
  resource_group_name  = var.postgresql_vnet_rg_name
}
resource "random_password" "adminpassword" {
  length  = 20
  special = true
}
resource "azurerm_key_vault_secret" "adminusername" {
  name         = "${var.postgresql_flexible_server_name}-admin"
  value        = var.postgresql_admin_login
  key_vault_id = var.kv_id
}
resource "azurerm_key_vault_secret" "adminpassword" {
  name         = "${var.postgresql_flexible_server_name}-admin-password"
  value        = random_password.adminpassword.result
  key_vault_id = var.kv_id
}
resource "azurerm_postgresql_flexible_server" "this" {
  name                   = var.postgresql_flexible_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.psql_version
  delegated_subnet_id    = data.azurerm_subnet.subnet.id
  private_dns_zone_id    = var.private_dns_zone_id
  administrator_login    = var.postgresql_admin_login
  administrator_password = random_password.adminpassword.result
  zone                   = var.zone
  storage_mb             = var.storage_mb
  sku_name               = var.sku_name
  backup_retention_days  = var.backup_retention_days
  authentication {
    active_directory_auth_enabled = true
    password_auth_enabled         = true
    tenant_id                     = data.azurerm_client_config.current.tenant_id
  }
}
resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = var.postgresql_db_name
  server_id = azurerm_postgresql_flexible_server.this.id
  collation = var.collation
  charset   = var.charset
}
# data "azuread_group" "admin" {
#   display_name     = var.azuread_group_name
#   security_enabled = true
# }
# resource "azurerm_postgresql_flexible_server_active_directory_administrator" "aad_admin" {
#   server_name         = azurerm_postgresql_flexible_server.this.name
#   resource_group_name = var.resource_group_name
#   tenant_id           = data.azurerm_client_config.current.tenant_id
#   object_id           = data.azuread_group.admin.object_id
#   principal_name      = data.azuread_group.admin.display_name
#   principal_type      = var.principal_type
# }