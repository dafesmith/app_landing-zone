resource "azurerm_network_security_group" "this" {
  resource_group_name = var.resource_group_name
  name                = var.name
  location            = var.location
  lifecycle { ignore_changes = [tags] }
}
