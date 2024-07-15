resource "azurerm_route_table" "this" {
  resource_group_name = var.resource_group_name
  name                = var.name
  location            = var.location
  lifecycle { ignore_changes = [tags] }
}