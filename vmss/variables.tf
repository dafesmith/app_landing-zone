variable "name" {
  description = "It is indicating the name of VM scale set"
  type        = string
}
variable "resource_group_name" {
  description = "It is indicating name of resource group"
  type        = string
}
variable "location" {
  description = "It is indicating location of resource group"
  type        = string
}
# variable "network_name" {
#   description = "This is vnet used for VMs in scaleset"
#   type        = string
# }
variable "subnet_id" {
  description = "This is subnet used for VMs in scaleset"
  type        = string
}
variable "nsg_id" {
  description = "This is subnet used for VMs in scaleset"
  type        = string
}
# variable "ports" {
#   description = "List of NSQ ports"
#   type        = list(number)
#   default     = [4150, 4151, 4160, 4161, 4171]
# }
variable "storage_account" {
  description = "Storage account for mounting "
  type        = string
}
variable "container_name" {
  description = "Name of blob container on the storage account."
  type        = string
}
variable "vmss_sku" {
  type = string
}
variable "vmss_number_of_instance" {
  type    = number
  default = 1
}
variable "vmss_admin_user" {
  description = "User name to use as the admin account on the VMs that will be part of the VM scale set"
  default     = "adminuser"
}
variable "vmss_admin_password" {
  description = "Default password for admin account"
  default     = "P@ssw0rd1234!"
  sensitive   = true
}
variable "vmss_disable_password_authentication" {
  type    = bool
  default = false
}
variable "vmss_vm_source_image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "The defines the VM image used in the VMss."
  nullable    = false
}
variable "vmss_vm_os_disk" {
  type = object({
    storage_account_type = string
    caching              = string
  })
  description = "The defines the VM os disk used in the VMss."
  nullable    = false
}
variable "lb_sku" {
  type = string
}
variable "lb_probes" {
  type = map(object({
    name                            = optional(string)
    protocol                        = optional(string, "Tcp")
    port                            = optional(number, 80)
    interval_in_seconds             = optional(number, 15)
    probe_threshold                 = optional(number, 1)
    request_path                    = optional(string)
    number_of_probes_before_removal = optional(number, 2)
  }))
  default     = {}
  description = "A list of objects that specify the Load Balancer probes to be created."
}
variable "lb_rules" {
  type = map(object({
    name                              = optional(string)
    frontend_ip_configuration_name    = optional(string)
    protocol                          = optional(string, "Tcp")
    frontend_port                     = optional(number, 3389)
    backend_port                      = optional(number, 3389)
    backend_address_pool_resource_ids = optional(list(string)) # multiple back end pools ONLY IF gateway sku load balancer
    backend_address_pool_object_names = optional(list(string)) # multiple back end pools ONLY IF gateway sku load balancer
    probe_resource_id                 = optional(string)
    probe_object_name                 = optional(string)
    enable_floating_ip                = optional(bool, false)
    idle_timeout_in_minutes           = optional(number, 4)
    load_distribution                 = optional(string, "Default")
    disable_outbound_snat             = optional(bool, false) # set `diasble_outbound_snat` to true when same frontend ip configuration is referenced by outbout rule and lb rule
    enable_tcp_reset                  = optional(bool, false)
  }))
  default     = {}
  description = "A list of objects that specifies the Load Balancer rules for the Load Balancer."
}

variable "env_nsq_custom_data" {type = string}