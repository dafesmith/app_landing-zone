# variable "subscriptionid" {
#   type        = string
#   description = "Provide a subscription ID for creating the resources"
# }

variable "instancename" {
  type        = string
  description = "Valid name for SQL Managed Instance as per Accruent's Naming convention"
}

variable "resourcegroup_name" {
  type        = string
  description = "Resource group name where SQL managed instance will be created"
}

variable "location" {
  type        = string
  description = "Location of Managed Instance"
}

variable "vnet" {
  type        = string
  description = "Provide the VNET name to for VNET integration"
}

variable "vnet-resourcegroup" {
  type        = string
  description = "Provide the Resource Group of VNET."
}

variable "snet" {
  type        = string
  description = "Provide the Subnet delegated to SQL Managed Instance. Netowrk Security group and route table will be created and attached to this Subnet"
}

variable "adminuser" {
  type        = string
  description = "Provide a Admin user, this user will be saved to KeyVault. A random password will be created and saved in KeyVault"
}

variable "keyvaultname" {
  type        = string
  description = "Provide the name of KeyVault to save the admin user and Password"
}

variable "keyvault-resource_group_name" {
  type        = string
  description = "Provide the KeyVault resource group to fetch details and save secret"
}

variable "sku_name" {
  type        = string
  description = "Provide SKU Name for the SQL Managed Instance. GP_Gen5 for General Purpose "
}

variable "storagesize" {
  type        = number
  description = "Storage space for the SQL Managed instance. Should be a multiple of 32 (GB)."
}

variable "vcore" {
  type        = number
  description = "Number of cores. Value should be 4, 8, 16, or 24 "
}
variable "licensetype" {
  type        = string
  default     = "LicenseIncluded"
  description = "Provide the license type."
}
variable "backupstorage" {
  type        = string
  description = "Storage account type used to store backups for this database. Values are GRS, LRS, ZRS"
}

variable "iszoneredundant" {
  type        = bool
  description = "For Production and Customer Sandbox QQL Managed Instance Should be zone redundant. For Dev, specify as False"
}

variable "entraadmin" {
  type        = string
  description = "Login name of the Entra principal to set as the Managed Instance Administrator."
}
