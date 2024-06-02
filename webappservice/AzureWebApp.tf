# Create a Resource Group
resource "azurerm_resource_group" "appservice-rg" {
  name     = "${var.app_name}-${var.environment}_rg"
  location = var.location
  tags = {
    description = "POCs Demo"
    environment = "POC"
    owner       = "CloudQuickPoCs"  
  }
}

# Create the App Service Plan
resource "azurerm_app_service_plan" "service-plan" {
  name                = "${var.app_name}-${var.environment}_service-plan"
  location            = azurerm_resource_group.appservice-rg.location
  resource_group_name = azurerm_resource_group.appservice-rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    description = "POCs Demo"
    environment = var.environment
    owner       = var.owner
  }
}

# Create the App Service
resource "azurerm_app_service" "app-service" {
  name                = "${var.app_name}-${var.environment}"
  location            = azurerm_resource_group.appservice-rg.location
  resource_group_name = azurerm_resource_group.appservice-rg.name
  app_service_plan_id = azurerm_app_service_plan.service-plan.id

  site_config {
    linux_fx_version = "JAVA|17"
  }

  tags = {
    description = "POCs Demo"
    environment = var.environment
    owner       = var.owner 
  }
}
