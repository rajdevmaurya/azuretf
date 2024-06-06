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
    key                  = "+mms.tfstate"
  }
}

provider "azurerm" {
  features {}
}
module "vm_service_prod" {
	source = "./mms_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "abcd"
	os_type             = "Windows"
	app_name            = "mms1432"
	app_code            = "mms"
	no_of_app_count     = 2
}
