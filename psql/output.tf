output "server_object" {
  value = azurerm_postgresql_flexible_server.this
}
output "database_object" {
  value = azurerm_postgresql_flexible_server_database.this
}