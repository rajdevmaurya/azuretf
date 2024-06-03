module "app_service_prod" {
	source = "./apm1432_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "abcd"
	os_type             = "Windows"
	app_name            = "apm1432"
	app_code            = "gig"
	no_of_app_count     = 2
}
