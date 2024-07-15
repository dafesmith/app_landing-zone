data "azurerm_virtual_network" "virtualnetwork" {
  name                = var.vnet
  resource_group_name = var.vnet-resourcegroup
}

data "azurerm_subnet" "subnet" {
  name                 = var.snet
  virtual_network_name = var.vnet
  resource_group_name  = var.vnet-resourcegroup
}

data "azurerm_key_vault" "keyvault" {
  name                = var.keyvaultname
  resource_group_name = var.keyvault-resource_group_name
}

resource "random_password" "adminpassword" {
  length  = 20
  special = true
}

# resource "azurerm_key_vault_secret" "adminusername" {
#   name         = "${var.instancename}--${var.adminuser}"
#   value        = var.adminuser
#   key_vault_id = data.azurerm_key_vault.keyvault.id
# }

# resource "azurerm_key_vault_secret" "adminpassword" {
#   name         = "${var.instancename}--admin-password"
#   value        = random_password.adminpassword.result
#   key_vault_id = data.azurerm_key_vault.keyvault.id
#   depends_on   = [azurerm_key_vault_secret.adminusername]
# }

# CREATING AZURE SQL MANAGED INSTANCE
data "azurerm_client_config" "current" {}

resource "azurerm_mssql_managed_instance" "azuresqlmanagedinstance" {
  name                         = var.instancename
  resource_group_name          = var.resourcegroup_name
  location                     = var.location
  license_type                 = var.licensetype
  sku_name                     = var.sku_name
  storage_size_in_gb           = var.storagesize
  subnet_id                    = data.azurerm_subnet.subnet.id
  vcores                       = var.vcore
  timezone_id                  = "utc"
  storage_account_type         = var.backupstorage
  administrator_login          = var.adminuser
  administrator_login_password = random_password.adminpassword.result
  identity {
    type = "SystemAssigned"
  }
  lifecycle { ignore_changes = [tags] }
}


# # GRANT ACCESS ON ENTRA FOR AZURE AD AUTHENTICATION

# resource "azuread_directory_role" "reader" {
#   display_name = "Directory Readers"
# }

# resource "azuread_directory_role_assignment" "entraassignment" {
#   role_id             = azuread_directory_role.reader.object_id
#   principal_object_id = azurerm_mssql_managed_instance.azuresqlmanagedinstance.identity[0].principal_id
# }

# # SET ENTRA ADMIN

# data "azuread_user" "entraadminuser" {
#   user_principal_name = var.entraadmin
# }
# resource "azurerm_mssql_managed_instance_active_directory_administrator" "setentra-admin" {
#   managed_instance_id = azurerm_mssql_managed_instance.azuresqlmanagedinstance.id
#   login_username      = var.entraadmin
#   object_id           = data.azuread_user.entraadminuser.object_id
#   tenant_id           = data.azurerm_client_config.current.tenant_id
# }