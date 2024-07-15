# Order of resouce creation
# Vnet with a subnet for IP
# azurerm_lb nsq_vmss_lb depends on subnet
# azurerm_lb_backend_address_pool.nsq_bpepool
# A storage blob container (needed by VM customerData)
# azurerm_linux_virtual_machine_scale_set my_vmss - Needs System Managed Identity to access storage
# VM scaleset does not support system-assigned identity enabled

# Find existing subnet
# data "azurerm_subnet" "nsq_subnet" {
#   name                 = var.subnet
#   virtual_network_name = var.network
#   resource_group_name  = "rg-zue-sandbox-vnet"
# }

# output "subnet_id" {
#   value = data.azurerm_subnet.nsq_subnet.id
# }

# # use existing key vault 
# data "azurerm_key_vault" "nsq_vault" {
#   name                = "ems-kendric-poc-dev"
#   resource_group_name = "rg-zue-sandbox-ems-kv-01"
# }

# output "vault_id" {
#   value = data.azurerm_key_vault.nsq_vault.id
# }

# data "azurerm_key_vault_secret" "storage_key" {
#   name         = "sharedsecret----nsq-storage-key"
#   key_vault_id = data.azurerm_key_vault.nsq_vault.id
# }

# output "storage_key" {
#   value     = data.azurerm_key_vault_secret.storage_key.value
#   sensitive = true
# }

resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  sku                             = var.vmss_sku
  instances                       = var.vmss_number_of_instance
  admin_username                  = var.vmss_admin_user
  admin_password                  = var.vmss_admin_password
  disable_password_authentication = var.vmss_disable_password_authentication

  source_image_reference {
    publisher = var.vmss_vm_source_image.publisher
    offer     = var.vmss_vm_source_image.offer
    sku       = var.vmss_vm_source_image.sku
    version   = var.vmss_vm_source_image.version
  }

  network_interface {
    name                      = "${var.name}-nic"
    primary                   = true
    network_security_group_id = var.nsg_id

    ip_configuration {
      name                                   = "${var.name}-ip"
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.this.id]
      #application_security_group_ids = [azurerm_application_security_group.nsq_asg.id]
    }
  }

  os_disk {
    storage_account_type = var.vmss_vm_os_disk.storage_account_type
    caching              = var.vmss_vm_os_disk.caching
  }

  # Since these can change via auto-scaling outside of Terraform,
  # let's ignore any changes to the number of instances
  lifecycle {
    ignore_changes = [instances]
  }
  custom_data = base64encode(var.env_nsq_custom_data)
}