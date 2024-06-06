terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.99.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-cloudquickpocs"
    storage_account_name = "ccpsazuretf0001"
    container_name       = "ccpterraformstatefile"
    key                  = "nia.tfstate"
  }
}

provider "azurerm" {
  features {}
}
module "vm_service_prod" {
	source = "./nia_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "abcd"
	os_type             = "Linux"
	resource_group_name  = "finance"
	app_name            = "nodev-apm01"
	app_code            = "nia"
	no_of_app_count     = 1
}
