module "vm_service_prod" {
	source = "./mms_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "MMTNL"
	os_type             = "Windows"
	app_name            = "apm-mms-1432"
	app_code            = "mms"
	no_of_app_count     = 2
}
