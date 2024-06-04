module "app_service_prod" {
	source = "./abcd_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "abcd"
	os_type             = "Windows"
	app_name            = "abcd"
	app_code            = "nia"
	no_of_app_count     = 2
}
