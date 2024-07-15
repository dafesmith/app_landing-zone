resource "azurerm_service_plan" "this" {
  name                         = var.name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  os_type                      = var.os_type
  sku_name                     = var.sku_name
  zone_balancing_enabled       = var.zone_balancing_enabled
  worker_count                 = var.worker_count
  maximum_elastic_worker_count = var.maximum_elastic_worker_count
  per_site_scaling_enabled     = var.per_site_scaling_enabled
}