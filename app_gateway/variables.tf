variable "name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "enable_http2" {
  type = bool
  default = false  
}
variable "subnet_name" { type = string }
variable "public_ip_sku" { type = string }
variable "public_ip_allocation_method" { type = string }
variable "public_ip_zones" {
  type    = list(string)
  default = ["1", "2", "3"]
}
variable "sku" {
  type = object({
    name     = string 
    tier     = string 
    capacity = number   #Number of virtual instances to support App Gwy. This property is optional if autoscale_configuration is set.
  }) 
  description = "Defines the application gateway's sku."
  nullable    = false
}
variable "gateway_ip_configuration" {
    type = object({
    name      = string 
    subnet_id = string 
  }) 
  description = "Defines the application gateway's ip config."
  nullable    = false
}
variable "frontend_ip_configuration_public" {
    type = object({
    name      = string 
    public_ip_address_id = string            #ip address of nic with public ip
  }) 
  description = "Defines the application gateway's frontend_ip_configuration public"
  nullable    = false
}
variable "frontend_ip_configuration_private" {
    type = object({
    name      = string 
    private_ip_address            =  string 
    private_ip_address_allocation = string       # "Static" 
    subnet_id      = string
  }) 
  description = "Defines the application gateway's frontend_ip_configuration private"
  nullable    = false
}
variable "managed_identity_type" {
  type = map(object({
    type     = string 
    identity_ids     = list(string)
  }) )
}
variable "ssl_cert_name" { type = string }
variable "key_vault_cert_secret_id" { 
  type = string 
  description = "ssl cert secret id"
}
# variable "frontend_port" {
#   type = list(object({
#     name = string 
#     port = string 
#   }))
#   nullable    = false  
# }