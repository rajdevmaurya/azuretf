terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.99.0"
    }
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
	app_name            = "apm1432"
	app_code            = "nia"
	no_of_app_count     = 1
}
