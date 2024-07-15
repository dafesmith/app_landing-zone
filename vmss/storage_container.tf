resource "azurerm_storage_container" "nsq_blob_container" {
  name                  = var.container_name
  storage_account_name  = var.storage_account
  container_access_type = "private"
}