#block to create security group allowing traffic from port 22 (SSH) and port 80(http)
resource "aws_security_group" "sg" {
  name   = var.name
  vpc_id = var.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      protocol    = "tcp"
      to_port     = port.value
      cidr_blocks = [var.ip_addresses]
    }
  }
  // Terraform removes the default rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [0.0.0.0/0]
  }
  tags = {
    Name = "manager_SG"
  }
}
