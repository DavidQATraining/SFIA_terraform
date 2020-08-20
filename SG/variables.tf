variable "vpc_id" {}

variable "ingress_ports" {
  type        = list(number)
  default     = [22]
  description = "ingress ports"
}

variable "name"{}

variable "ip_addresses"{
  default = "0.0.0.0/0"
}

