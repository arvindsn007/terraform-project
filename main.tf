provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source          = "./vpc" 
  vpc_cidr        = "10.0.0.0/16"
  public_cidrs    = ["10.0.1.0/24", "10.0.2.0/24"]
  private_cidrs   = ["10.0.3.0/24", "10.0.4.0/24"]
  transit_gateway = "${module.transit_gateway.transit_gateway}"
}

module "transit_gateway" {
  source         = "./transit_gateway"
  vpc_id         = "${module.vpc.vpc_id}"
  public_subnet1 = "${module.vpc.subnet1}"
  public_subnet2 = "${module.vpc.subnet2}"
}