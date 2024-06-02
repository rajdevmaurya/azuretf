module "app_service_prod" {
    source = "./webappservice/"
	location            = "East US"
	environment         = "dev"
	owner               = "RAjdev"
	description         = "Linux webapp"
	app_name            = "myrgroup01"
	no_of_app_count     = 2
}