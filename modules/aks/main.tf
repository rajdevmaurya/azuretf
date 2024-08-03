# Datasource to get Latest Azure AKS latest Version
data "azurerm_kubernetes_service_versions" "current" {
  location = var.location
  include_preview = false  
}
 

resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                  = "techtutorialwithpiyush-aks-cluster"
  location              = var.location
  resource_group_name   = var.resource_group_name
  dns_prefix            = "${var.resource_group_name}-cluster"           
  kubernetes_version    =  data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${var.resource_group_name}-nrg"
  
  default_node_pool {
    name       = "defaultpool"
    vm_size    = "Standard_DS2_v2"
    zones   = [1, 2, 3]
    enable_auto_scaling  = true
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type"    = "system"
      "environment"      = "prod"
      "nodepoolos"       = "linux"
     } 
   tags = {
      "nodepool-type"    = "system"
      "environment"      = "prod"
      "nodepoolos"       = "linux"
   } 
  }

  service_principal  {
    client_id = var.client_id
    client_secret = var.client_secret
  }



  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
        key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDDXSYq506tHWH9M0+MqKHxmSHBxa42A7fxY67nbDkAXBpTxqqyaIIjPCeZoYUNlIgHBXwLvY1PE536xTOfjwUZbmcXcZgSfc1LW/MF/3YyNzEnHC0sQy5xynl6a6DiKlPZ8WjucMf3o29mULk+kg15eahSapzjDgu0hB0+e2AauQFb3ie9BIgepckHWqaRyKSq6Lbs+j4X64HGL8u0lfm9Wdc8Uam6TzyejcwCavSzW/fA4masb8XhsTe1aIVLuzbD5SasbgSwdvJ9wr8qx4aZpmo8KsLATnFPN/MLrXKzANpDN6KpSp0GD32JNWsFgecEv+wedTO0H6KM2Q7uRznancNDPT+S2CpwPkTc3c8kKjuaKa7A2vi6lltsLpZTgY4VNjWx1eVVCvQR/Gu4DfB2xd8Vicyy0fMw8TJk8Eau72I2tMJCt9HxGQ97vnNxIfzFvKu5WxAXeJn/N9dCndUDjPJ4KoQp3OPuWnPttWTbRN3XU3OEXyqIldneFE3hUVv3v0CsjGhiX+xXiWqAJaPCUANP3I/gtN+BlLjjmrg5AeSVzugIGe2xzc3pykmPoU6Tf+Dg72ciTI358EVh/CUus9N3iMSGZXyayPPxhYM6JgW8mY3L1sgSRQPgsoWlNWEqxRX7wZSDcNEAba1Pv0SoqI0gAWWv8Xo2ZJekRkD7NQ=="
    }
  }

  network_profile {
      network_plugin = "azure"
      load_balancer_sku = "standard"
  }

    
  }


