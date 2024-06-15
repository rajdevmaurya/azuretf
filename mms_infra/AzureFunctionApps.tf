resource "random_id" "identifier" {
  byte_length = 8
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    environment = var.tag
  }
}

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.sku_storage

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_app_service_plan" "main" {
  name                = "${var.function_app_name}-asp"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "FunctionApp"
  reserved            = true # Required for Linux

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "main" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.main.name
  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
  os_type                    = "linux"
  runtime                    = "python"
  runtime_version            = var.python_version
  version                    = var.functions_version
  app_service_plan_id        = azurerm_app_service_plan.main.id

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "python"
    AzureWebJobsStorage      = azurerm_storage_account.main.primary_connection_string
  }

  site_config {
    always_on = false
  }
}