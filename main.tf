provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
}

module "VPC"{
  source = "./VPC"
}

module "SG"{
  source = "./SG"
}

module "EC2"{
  source = "./EC2"
}