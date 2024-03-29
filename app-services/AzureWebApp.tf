# Create a Resource Group
resource "azurerm_resource_group" "appservice-rg" {
  name     = "MyMgmtApp-RG001"
  location = "East US"
  tags = {
    description = "My Demo"
    environment = "Dev"
    owner       = "MyMgmtApp"  
  }
}

# Create the App Service Plan
resource "azurerm_app_service_plan" "service-plan" {
  name                = "user-mgmt"
  location            = azurerm_resource_group.appservice-rg.location
  resource_group_name = azurerm_resource_group.appservice-rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    description = "My Demo"
    environment = "Dev"
    owner       = "MyMgmtApp"  
  }
}

# Create the App Service
resource "azurerm_app_service" "app-service" {
  name                = "MyMgmtApp-Web-app-service-07"
  location            = azurerm_resource_group.appservice-rg.location
  resource_group_name = azurerm_resource_group.appservice-rg.name
  app_service_plan_id = azurerm_app_service_plan.service-plan.id

  site_config {
    linux_fx_version = "JAVA|17"
  }

  tags = {
    description = "My Demo"
    environment = "Dev"
    owner       = "MyMgmtApp"  
  }
}
