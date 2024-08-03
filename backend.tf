terraform {
  backend "azurerm" {
    resource_group_name  = "backendrg"
    storage_account_name = "backendsa107"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
