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

module "virtual_network" {
  source = "./modules/virtual-network"
  # Add required variables
  AKS_VNET_NAME               = "aks-vnet"
  AKS_ADDRESS_SPACE           = "10.0.0.0/16"
  AKS_SUBNET_NAME             = "aks-subnet"
  AKS_SUBNET_ADDRESS_PREFIX   = "10.0.1.0/24"
  APPGW_SUBNET_NAME           = "appgw-subnet"
  APPGW_SUBNET_ADDRESS_PREFIX = "10.0.2.0/24"

  LOCATION                    = "East US"
  RESOURCE_GROUP_NAME         = "rg-devops"

  ACR_VNET_NAME               = "acr-vnet"
  ACR_SUBNET_NAME             = "acr-subnet"
  ACR_SUBNET_ADDRESS_PREFIX   = "10.1.1.0/24"
  ACR_ADDRESS_SPACE           = "10.1.0.0/16"

  AGENT_VNET_NAME             = "agent-vnet"
  AGENT_SUBNET_NAME           = "agent-subnet"
  AGENT_SUBNET_ADDRESS_PREFIX = "10.2.1.0/24"
  AGENT_ADDRESS_SPACE         = "10.2.0.0/16"
}


module "agent_vm" {
  source = "./modules/agent-vm"
  LOCATION                    = "East US"
  RESOURCE_GROUP_NAME         = "rg-devops"
  AGENT_VM_NAME = "agent-vm"
  VM_SIZE             = "Standard_DS1_v2"
  ADMIN_USERNAME      = "azureuser"
  ADMIN_PASSWORD      =  "P@ssw0rd!"
}
module "application_gateway" {
  source = "./modules/application-gateway"
  APPGW_PUBLIC_IP_NAME = "my-appgw-public-ip"
  APP_GATEWAY_NAME     = "my-app-gateway"
  VIRTUAL_NETWORK_NAME = "aks-vnet"
  RESOURCE_GROUP_NAME  = "rg-devops"
  LOCATION             = "East US"
}

module "log_analytics" {
  source = "./modules/log-analytics"
  RESOURCE_GROUP_NAME  = "rg-devops"
  LOCATION             = "East US"
  # Add required variables
}


