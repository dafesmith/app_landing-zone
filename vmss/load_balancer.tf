resource "azurerm_lb" "this" {
  name                = "${var.name}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                       = "${var.name}-private"
    subnet_id                  = var.subnet_id
    private_ip_address_version = "IPv4"

  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id = azurerm_lb.this.id
  name            = "${var.name}-lb-BackEndAddressPool"
}

# Create all probes
resource "azurerm_lb_probe" "this" {
  for_each = var.lb_probes

  loadbalancer_id     = azurerm_lb.this.id
  name                = coalesce(each.value.name)
  port                = each.value.port
  interval_in_seconds = each.value.interval_in_seconds
  number_of_probes    = each.value.number_of_probes_before_removal
  probe_threshold     = each.value.probe_threshold
  protocol            = each.value.protocol
  request_path        = (each.value.protocol == "Http" || each.value.protocol == "Https") ? each.value.request_path : null
}

# resource "azurerm_lb_probe" "nsq_vmss_nsqadmin" {
#   loadbalancer_id = azurerm_lb.this.id
#   name            = "nsqadmin"
#   port            = 4171
# }

# resource "azurerm_lb_probe" "nsq_vmss_nsqd" {
#   loadbalancer_id = azurerm_lb.this.id
#   name            = "nsqd"
#   port            = 4150
# }

# resource "azurerm_lb_probe" "nsq_vmss_nsqd_2" {
#   loadbalancer_id = azurerm_lb.this.id
#   name            = "nsqd-2"
#   port            = 4151
# }

# resource "azurerm_lb_probe" "nsq_vmss_nsqlookup" {
#   loadbalancer_id = azurerm_lb.this.id
#   name            = "nsqlookup"
#   port            = 4160
# }

# resource "azurerm_lb_probe" "nsq_vmss_nsqlookup_2" {
#   loadbalancer_id = azurerm_lb.this.id
#   name            = "nsqlookup-2"
#   port            = 4161
# }

# Create all lb rules
resource "azurerm_lb_rule" "this" {
  for_each = var.lb_rules

  loadbalancer_id                = azurerm_lb.this.id
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = azurerm_lb.this.frontend_ip_configuration[0].name
  #frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  frontend_port            = each.value.frontend_port
  name                     = "rule-${each.value.name}"
  protocol                 = each.value.protocol
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.this.id]
  #backend_address_pool_ids       = each.value.backend_address_pool_resource_ids != null || each.value.backend_address_pool_object_names != null ? coalesce(each.value.backend_address_pool_resource_ids, [for x in each.value.backend_address_pool_object_names : azurerm_lb_backend_address_pool.this[x].id if length(each.value.backend_address_pool_object_names) > 0]) : null
  disable_outbound_snat   = each.value.disable_outbound_snat
  enable_floating_ip      = each.value.enable_floating_ip
  enable_tcp_reset        = each.value.enable_tcp_reset
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  load_distribution       = each.value.load_distribution
#  probe_id                = coalesce(azurerm_lb_probe.this[each.value.probe_object_name].id, each.value.probe_resource_id)
  probe_id                = each.value.probe_resource_id
}

# resource "azurerm_lb_rule" "nsq_lbnatrule_nsqadmin" {
#   loadbalancer_id                = azurerm_lb.this.id
#   name                           = "nsqadmin"
#   protocol                       = "Tcp"
#   frontend_port                  = 4171
#   backend_port                   = 4171
#   backend_address_pool_ids       = [azurerm_lb_backend_address_pool.nsq_bpepool.id]
#   frontend_ip_configuration_name = azurerm_lb.this.frontend_ip_configuration[0].name
#   probe_id                       = azurerm_lb_probe.nsq_vmss_nsqadmin.id
# }

# resource "azurerm_lb_rule" "nsq_lbnatrule_nsqd" {
#   loadbalancer_id                = azurerm_lb.this.id
#   name                           = "nsqd"
#   protocol                       = "Tcp"
#   frontend_port                  = 4150
#   backend_port                   = 4150
#   backend_address_pool_ids       = [azurerm_lb_backend_address_pool.nsq_bpepool.id]
#   frontend_ip_configuration_name = azurerm_lb.this.frontend_ip_configuration[0].name
#   probe_id                       = azurerm_lb_probe.nsq_vmss_nsqd.id
# }

# resource "azurerm_lb_rule" "nsq_lbnatrule_nsqd_2" {
#   loadbalancer_id                = azurerm_lb.this.id
#   name                           = "nsqd-2"
#   protocol                       = "Tcp"
#   frontend_port                  = 4151
#   backend_port                   = 4151
#   backend_address_pool_ids       = [azurerm_lb_backend_address_pool.nsq_bpepool.id]
#   frontend_ip_configuration_name = azurerm_lb.this.frontend_ip_configuration[0].name
#   probe_id                       = azurerm_lb_probe.nsq_vmss_nsqd_2.id
# }

# resource "azurerm_lb_rule" "nsq_lbnatrule_nsqlookup" {
#   loadbalancer_id                = azurerm_lb.this.id
#   name                           = "nsqlookup"
#   protocol                       = "Tcp"
#   frontend_port                  = 4160
#   backend_port                   = 4160
#   backend_address_pool_ids       = [azurerm_lb_backend_address_pool.nsq_bpepool.id]
#   frontend_ip_configuration_name = azurerm_lb.this.frontend_ip_configuration[0].name
#   probe_id                       = azurerm_lb_probe.nsq_vmss_nsqlookup.id
# }

# resource "azurerm_lb_rule" "nsq_lbnatrule_nsqlookup_2" {
#   loadbalancer_id                = azurerm_lb.this.id
#   name                           = "nsqlookup-2"
#   protocol                       = "Tcp"
#   frontend_port                  = 4161
#   backend_port                   = 4161
#   backend_address_pool_ids       = [azurerm_lb_backend_address_pool.nsq_bpepool.id]
#   frontend_ip_configuration_name = azurerm_lb.this.frontend_ip_configuration[0].name
#   probe_id                       = azurerm_lb_probe.nsq_vmss_nsqlookup_2.id
# }