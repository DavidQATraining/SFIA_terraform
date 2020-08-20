variable "vpc_id" {}

variable "ingress_ports_manager" {
  type        = list(number)
  default     = [22, 80, 8080]
  description = "ingress ports for manager"
}

variable "ingress_ports_worker" {
  type        = list(number)
  default     = [22]
  description = "ingress ports for worker"
}

