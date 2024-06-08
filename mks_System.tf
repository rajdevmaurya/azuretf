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
	source = "./mks_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "parag"
	os_type             = "Windows"
	app_name            = "mks14356"
	app_code            = "mks"
	no_of_app_count     = 2
}
