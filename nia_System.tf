module "vm_service_prod" {
	source = "./nia_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "NTCIA"
	os_type             = "Windows"
	app_name            = "apm-nia-1432"
	app_code            = "nia"
	no_of_app_count     = 2
}
