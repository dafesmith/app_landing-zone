resource "azurerm_application_gateway" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  zones        = ["1", "2", "3"]
  enable_http2 = var.enable_http2

  sku {
    name     = var.sku.name    
    tier     = var.sku.name    
    capacity = var.sku.cache   
  }

  gateway_ip_configuration {
    name      = var.gateway_ip_configuration.name
    subnet_id = var.gateway_ip_configuration.subnet_id
  }

  frontend_port {
    name = "port_80"
    port = 80
  }

  frontend_port {
    name = "port_443"
    port = 443
  }

  #public frontend ip_config
  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_public.name    
    public_ip_address_id = var.frontend_ip_configuration_public.public_ip_address_id         
  }

  #private frontend ip_config
  frontend_ip_configuration {
    name                          = var.frontend_ip_configuration_private.name 
    private_ip_address            = var.frontend_ip_configuration_private.private_ip_address 
    private_ip_address_allocation = var.frontend_ip_configuration_private.private_ip_address_allocation 
    subnet_id                     = var.frontend_ip_configuration_private.sub
  }

  dynamic "identity" {
    for_each = var.managed_identity_type == null ? [] : ["identity"]
    content {
      type         = identity.managed_identity_type
      identity_ids = identity.managed_identities.user_assigned_resource_ids
    }
  }

  ssl_certificate {
    name                = var.ssl_cert_name
    key_vault_secret_id = var.key_vault_cert_secret_id
  }

#?? Alex cannot figure how to get required customer info
  dynamic "backend_http_settings" {
    for_each = local.customers
    content {
      name                  = backend_http_settings.key
      cookie_based_affinity = "Disabled"
      port                  = 443
      protocol              = "Https"
      request_timeout       = 20
      probe_name            = backend_http_settings.key
    }
  }

  dynamic "backend_address_pool" {
    for_each = local.customers
    content {
      name  = backend_address_pool.key
      fqdns = ["${backend_address_pool.value["vanity"]}.${local.domain}"]

    }
  }

  dynamic "http_listener" {
    for_each = local.customers
    content {
      name                           = http_listener.key
      frontend_ip_configuration_name = "appg-zue-jlauck-public"
      frontend_port_name             = "port_443"
      host_name                      = "${http_listener.value["vanity"]}.${local.domain}"
      protocol                       = "Https"
      ssl_certificate_name           = "lauckserv.net"

    }
  }

  dynamic "request_routing_rule" {
    for_each = local.customers
    content {
      name                       = request_routing_rule.key
      priority                   = request_routing_rule.value["priority"]
      rule_type                  = "Basic"
      http_listener_name         = request_routing_rule.key
      backend_address_pool_name  = request_routing_rule.key
      backend_http_settings_name = request_routing_rule.key
    }
  }

  dynamic "probe" {
    for_each = local.customers
    content {
      host                = "${probe.value["vanity"]}.${local.domain}"
      interval            = 15
      name                = probe.key
      protocol            = "Https"
      path                = "/"
      timeout             = 30
      unhealthy_threshold = 3
    }
  }

  tags = merge(local.fortive_tags, local.accruent_tags)

}
