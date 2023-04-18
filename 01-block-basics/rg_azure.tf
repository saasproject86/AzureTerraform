terraform {
  required_version = ">= 1.1.8"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.49.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
}

