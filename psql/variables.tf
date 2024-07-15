variable "resource_group_name" {
  description = "Resource Group name to hold PSQL"
  type        = string
}
variable "location" {
  description = "Azure Region to hosr PSQL"
  type        = string
}
variable "postgresql_vnet_rg_name" {
  description = "Resource Group name for VNET"
  type        = string
}
variable "postgresql_vnet_name" {
  description = "VNET name"
  type        = string
}
variable "postgresql_subnet_name" {
  description = "Subnet Name"
  type        = string
}
variable "postgresql_flexible_server_name" {
  description = "PostgreSQL flexible server name"
  type        = string
}
variable "private_dns_zone_id" {
  description = "Private DNS zone ID"
  type        = string
}
variable "postgresql_admin_login" {
  description = "psql admin name"
  type        = string
}
variable "postgresql_db_name" {
  description = "Psql database name"
  type        = string
}
variable "azuread_group_name" {
  description = "AAD security Group"
  type        = string
}
variable "kv_id" {
  description = "KeyVault GUID. PostgreSQL amin name and password will be cretaed there."
  type        = string
}
variable "zone" { type = string }
variable "storage_mb" { type = string }
variable "sku_name" { type = string }
variable "backup_retention_days" { type = string }
variable "collation" { type = string }
variable "charset" { type = string }
variable "principal_type" { type = string }
variable "psql_version" { type = string }