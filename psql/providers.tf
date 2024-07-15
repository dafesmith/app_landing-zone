terraform {
  required_version = ">=1.7.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.33"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}
provider "azurerm" {
  features {}
}
data "azurerm_client_config" "current" {
}