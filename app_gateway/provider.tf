terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.96.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "> 4.0"
    }
  }
}

provider "azurerm" {
  features {
    subscription {
      prevent_cancellation_on_destroy = true
    }
  }

  # subscription_id = data.vault_generic_secret.subscriptions.data["sub-sandbox"]
  # client_id       = data.vault_generic_secret.network_automation.data["client-id"]
  # client_secret   = data.vault_generic_secret.network_automation.data["client-secret"]
  # tenant_id       = data.vault_generic_secret.network_automation.data["tenant-id"]

  skip_provider_registration = true
}
