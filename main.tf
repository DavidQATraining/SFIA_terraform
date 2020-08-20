provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
}

module "VPC" {
  source = "./VPC"
}

module "SG" {
  source = "./SG"
  vpc_id = module.VPC.vpc_id
}

module "EC2" {
  source                 = "./EC2"
  subnet_id              = module.VPC.subnet_a_id
  vpc_security_group_ids = module.SG.SG_id
}