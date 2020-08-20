provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
}

module "VPC" {
  source = "./VPC"
}

module "SG_master_myip" {
  source = "./SG"
  vpc_id = module.VPC.vpc_id
  name = "master_myip"
  ip_addresses = "54.246.203.80/32"
  ingress_ports = [22, 8080]
}

module "SG_master_open" {
  source = "./SG"
  vpc_id = module.VPC.vpc_id
  name = "master_open"
  ingress_ports = [80]
}

module "SG_worker" {
  source = "./SG"
  vpc_id = module.VPC.vpc_id
  name = "worker"
}

module "EC2_manager" {
  source                 = "./EC2"
  subnet_id              = module.VPC.subnet_a_id
  vpc_security_group_ids = [module.SG_master_open.SG_id, module.SG_master_myip.SG_id]
  name                   = "manager"
}

module "EC2_worker" {
  source                 = "./EC2"
  subnet_id              = module.VPC.subnet_a_id
  vpc_security_group_ids = [module.SG_worker.SG_id]
  name                   = "worker"
}

