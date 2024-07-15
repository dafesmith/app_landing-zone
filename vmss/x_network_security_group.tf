# resource "azurerm_network_security_group" "nsq_nsg" {
#   name                = "nsq-nsg"
#   location            = var.location
#   resource_group_name = var.resource_group

#   security_rule {
#     name                       = "nsq-ports"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_ranges     = var.ports
#     source_address_prefix      = "*"
#     #destination_application_security_group_ids = [azurerm_application_security_group.nsq_asg.id]
#   }

#   tags = var.tags
# }