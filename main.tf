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

module "private_acr" {
  source = "./modules/private-acr"
  RESOURCE_GROUP_NAME  = "rg-devops"
  LOCATION             = "East US"
  PRIVATE_ACR_NAME      = "myPrivateACR"
  ACR_SKU               = "Standard"
}

module "private_aks" {
  source = "./modules/private-aks"
  RESOURCE_GROUP_NAME  = "rg-devops"
  LOCATION             = "East US"
  NAME                           = "myAKSCluster"
  kubernetes_version             = "1.23.5"
  DNS_PREFIX                     = "myAKS"
  private_cluster_enabled        = true
  automatic_channel_upgrade      = "rapid"
  sku_tier                       = "Paid"  # Corrected value
  azure_policy_enabled           = true
  default_node_pool_name         = "default"
  default_node_pool_vm_size      = "Standard_DS2_v2"
  default_node_pool_enable_auto_scaling = true
  default_node_pool_enable_host_encryption = true
  default_node_pool_enable_node_public_ip = false
  default_node_pool_max_pods     = 110
  default_node_pool_max_count    = 5
  default_node_pool_min_count    = 1
  default_node_pool_node_count   = 3
  default_node_pool_os_disk_type = "Managed"
  admin_username                 = "azureuser"
  SSH_PUBLIC_KEY                 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC"
  network_dns_service_ip         = "10.0.0.10"
  network_plugin                 = "azure"
  network_service_cidr           = "10.0.0.0/16"
}

