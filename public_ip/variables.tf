variable "name" {
  description = "PIP name"
  type        = string
}
variable "resource_group_name" {
  description = "RG name for PIP"
  type        = string
}
variable "location" {
  description = "Azure region for PIP"
  type        = string
}
variable "allocation_method" {
  description = "PIP allocation methos"
  type        = string
}
variable "sku" {
  description = "PIP SKU"
  type        = string
}
variable "zones" {
  type = set(string)
  description = "[] or [1,2,3] "
  default = []
}