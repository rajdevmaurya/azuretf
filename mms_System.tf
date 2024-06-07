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
	source = "./mms_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "abcd"
	os_type             = "Windows"
	app_name            = "mms1432"
	app_code            = "mms"
	no_of_app_count     = 1
	resource_group_name     = "rg-terraform-web-sql-db"
	resource_group_location = "East US"
	app_service_plan_name   = "appserviceplan-web-21"
	app_service_name        = "terraform-web-021"
	sql_server_name         = "terraform-sqlserver-02133"
	sql_database_name       = "ProductsDB"
	sql_admin_login         = "user01"
	sql_admin_password      = "@Aa123456789!"
}
