output "app_service_url" {
  value       = azurerm_app_service.app-service.default_site_hostname
  description = "Default URL to access the app service." 
}