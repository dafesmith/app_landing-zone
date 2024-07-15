variable "name" {
  description = "It is indicating the name of appservice plan"
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

variable "os_type" {
  description = "It is indicating the kind of appservice plan"
  type        = string
}

variable "sku_name" {
  description = "It is indicating size of appservice plan"
  type        = string
}

# variable "reserved" {
#   description = "Whether this is a reserved Service Plan Type"
#   type        = bool
# }

variable "zone_balancing_enabled" {
  description = "Should the Service Plan balance across Availability Zones in the region[0]. Changing this forces a new resource to be created."
  type        = bool
}

variable "worker_count" {
  description = "The number of Workers (instances) to be allocated."
  type        = number
}

variable "maximum_elastic_worker_count" {
  description = "The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU."
  type        = number
  default     = null
}

variable "per_site_scaling_enabled" {
  description = "Should Per Site Scaling be enabled. Defaults to false."
  type        = string
}