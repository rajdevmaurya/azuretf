terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }

}

provider "azurerm" {
  features {}
}
module "fnapp_service_prod" {
	source = "./mms_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "abcd"
	os_type             = "Windows"
	app_name            = "mms1432"
	app_code            = "mms"
	no_of_app_count     = 1
    resource_group_name  = "rg-cloudquickpocs"
    tag = "create-function-app-consumption-python"
    function_app_name = "my-serverless-python-function"
    sku_storage = "sku_storage"
    functions_version =  4
    python_version  =  3.9
    storage_account_name       = "ccpterraformstatefile"
}
