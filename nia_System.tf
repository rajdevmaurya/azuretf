module "vm_service_prod" {
	source = "./nia_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "abcd"
	os_type             = "Windows"
	app_name            = "apm1432"
	app_code            = "nia"
	no_of_app_count     = 2
}
