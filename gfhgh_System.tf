terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.6.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-cloudquickpocs"
    storage_account_name = "ccpsazuretf0001"
    container_name       = "ccpterraformstatefile"
    key                  = "gfhgh.tfstate"
  }
}

provider "azurerm" {
  features {}
}
module "vm_service_prod" {
	source = "./gfhgh_infra/"
	resource_group_name     = "rg-terraform-web-sql-db"
	resource_group_location = "East US"
	app_service_plan_name   = "appserviceplan-web-21"
	app_service_name        = "terraform-web-021"
	sql_server_name         = "terraform-sqlserver-02133"
	sql_database_name       = "ProductsDB"
	sql_admin_login         = "user01"
	sql_admin_password      = "@Aa123456789!"
}
