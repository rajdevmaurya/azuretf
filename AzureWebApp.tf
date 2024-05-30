# Create a Resource Group
resource "azurerm_resource_group" "appservice-rg" {
  name     = "myrgroup01"
  location = "East US"
  tags = {
    description = "POCs Demo"
    environment = "POC"
    owner       = "CloudQuickPoCs"  
  }
}

# Create the App Service Plan
resource "azurerm_app_service_plan" "service-plan" {
  name                = "my-linux-service-plan-01"
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
    environment = "POC"
    owner       = "CloudQuickPoCs"  
  }
}

# Create the App Service
resource "azurerm_app_service" "app-service" {
  name                = "my-linux-app-service01"
  location            = azurerm_resource_group.appservice-rg.location
  resource_group_name = azurerm_resource_group.appservice-rg.name
  app_service_plan_id = azurerm_app_service_plan.service-plan.id

  site_config {
    linux_fx_version = "JAVA|17"
  }

  tags = {
    description = "POCs Demo"
    environment = "POC"
    owner       = "CloudQuickPoCs"  
  }
}
