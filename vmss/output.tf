output "vmss" {
  value = azurerm_linux_virtual_machine_scale_set.this
}
output "loadbalancer" {
  value = azurerm_lb.this
}
output "autoscalesetting" {
  value = azurerm_monitor_autoscale_setting.this
}