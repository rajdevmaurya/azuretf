module "vm_service_prod" {
	source = "./mms_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "fdg"
	os_type             = "Linux"
	app_name            = "apm1432"
	app_code            = "mms"
	no_of_app_count     = 2
}
