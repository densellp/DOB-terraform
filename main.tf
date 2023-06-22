# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  backend "azurerm" {
    resource_group_name  = "myTFResourceGroup"
    storage_account_name = "terraformbruh"
    container_name       = "terraform-state"
    key                  = "test.tfstate"
    use_oidc             = true
    subscription_id      = "3e16852e-8399-4c16-b246-16bf46bc3747"
    tenant_id            = "1b4a4fed-fed8-4823-a8a0-3d5cea83d122"
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "westus2"

}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "myTFVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rg.name
}
