variable "instance" {
  description = "This variable states the instance type for your ec2"
  default     = "t2.micro"
}

variable "region" {
  description = "This variable states the instance region for your ec2"
  default     = "eu-west-1"
}

variable "key_name" {
  description = "This variable states the instance key for your ec2"
  default     = "dave"
}

variable "ami" {
  description = "This variable states the instance ami for your ec2"
  default     = "ami-07ee42ba0209b6d77"
}

variable "cidr_block" {
  description = "This variable states the sub cidr block for your ec2"
  default     = "123.145.0.0/16"
}

variable "sub_cidr_block" {
  description = "This variable states the sub cidr block for your ec2"
  default     = "123.145.1.0/24"
}