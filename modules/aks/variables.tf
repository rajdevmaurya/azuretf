variable "location" {

}
 variable "resource_group_name" {}

variable "service_principal_name" {
  type = string
}

variable "client_id" {}
variable "client_secret" {
  type = string
  sensitive = true
}
variable "ssh_public_key" {
  description = "The SSH public key to access the AKS nodes"
  type        = string
}