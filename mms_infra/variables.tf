variable "location" {
  default = "eastus"
}

variable "random_identifier" {
  default = "${random_id.identifier.hex}"
}

variable "resource_group_name" {
  default = "abhi-azure-functions-rg-${random_identifier}"
}

variable "tag" {
  default = "create-function-app-consumption-python"
}

variable "storage_account_name" {
  default = "abhi${random_identifier}"
}

variable "function_app_name" {
  default = "abhi-serverless-python-function-${random_identifier}"
}

variable "sku_storage" {
  default = "Standard_LRS"
}

variable "functions_version" {
  default = "4"
}

variable "python_version" {
  default = "3.9"
}
