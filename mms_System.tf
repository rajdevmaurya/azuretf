module "app_service_prod" {
	source = "./mms_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "abcd"
	os_type             = "Windows"
	app_name            = "mms1432"
	app_code            = "mms"
	no_of_app_count     = 1
}
