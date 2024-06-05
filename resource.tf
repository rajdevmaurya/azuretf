resource "azurerm_resource_group" "appservice-rg" {
  name     = "finance"
  location = "East Us"
  tags = {
    description = "POCs Demo"
    environment = "System"
    owner       = "MyTest"  
  }
}