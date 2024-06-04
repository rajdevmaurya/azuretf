module "vm_service_prod" {
	source = "./gig_infra/"
	location            = "East US"
	environment         = "System"
	owner               = "abcd"
	os_type             = "Windows"
	app_name            = "gig1432"
	app_code            = "gig"
	no_of_app_count     = 2
}
