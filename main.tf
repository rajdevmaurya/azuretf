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
  RESOURCE_GROUP_NAME         = "my-resource-group"

  ACR_VNET_NAME               = "acr-vnet"
  ACR_SUBNET_NAME             = "acr-subnet"
  ACR_SUBNET_ADDRESS_PREFIX   = "10.1.1.0/24"
  ACR_ADDRESS_SPACE           = "10.1.0.0/16"

  AGENT_VNET_NAME             = "agent-vnet"
  AGENT_SUBNET_NAME           = "agent-subnet"
  AGENT_SUBNET_ADDRESS_PREFIX = "10.2.1.0/24"
  AGENT_ADDRESS_SPACE         = "10.2.0.0/16"
}

module "sql_dbserver" {
  source = "./modules/sql-dbserver"
  # Add required variables
  RESOURCE_GROUP_NAME = var.RESOURCE_GROUP_NAME
  LOCATION            = var.LOCATION
  DBSERVER_NAME       = var.DBSERVER_NAME
  DBUSERNAME          = var.DBUSERNAME
  DBPASSWORD          = var.DBPASSWORD
  DB_NAME             = var.DB_NAME
  COLLATION           = var.COLLATION
  
}

module "agent_vm" {
  source = "./modules/agent-vm"
  # Add required variables
  RESOURCE_GROUP_NAME = var.RESOURCE_GROUP_NAME
  LOCATION            = var.LOCATION
  AGENT_VM_NAME       = var.AGENT_VM_NAME
  VM_SIZE             = var.VM_SIZE
  ADMIN_USERNAME      = var.ADMIN_USERNAME
  ADMIN_PASSWORD      = var.ADMIN_PASSWORD
}

module "application_gateway" {
  source = "./modules/application-gateway"
  # Add required variables
  VIRTUAL_NETWORK_NAME      = var.VIRTUAL_NETWORK_NAME
  RESOURCE_GROUP_NAME       = var.RESOURCE_GROUP_NAME
  LOCATION                  = var.LOCATION
  APPGW_PUBLIC_IP_NAME      = var.APPGW_PUBLIC_IP_NAME
  APP_GATEWAY_NAME          = var.APP_GATEWAY_NAME
}

module "log_analytics" {
  source = "./modules/log-analytics"
  # Add required variables
  LOCATION            = var.LOCATION
  RESOURCE_GROUP_NAME = var.RESOURCE_GROUP_NAME
  WORKSPACE_NAME      = "logana-01"
  SKU                 = "PerGB2018"
  RETENTION_IN_DAYS   = 7
}

module "private_acr" {
  source = "./modules/private-acr"
  # Add required variables
}

module "private_aks" {
  source = "./modules/private-aks"
  # Add required variables
}
