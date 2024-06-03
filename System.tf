module "app_service_prod" {
	source = "./demomywebapp01_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "abcd"
	description         = "Linux webapp"
	app_name            = "myrgroup01"
	no_of_app_count     = 2
}
