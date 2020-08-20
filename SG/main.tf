#block to create security group allowing traffic from port 22 (SSH) and port 80(http)
resource "aws_security_group" "manager" {
  name   = "manager"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports_manager
    content {
      from_port   = port.value
      protocol    = "tcp"
      to_port     = port.value
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  // Terraform removes the default rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "manager_SG"
  }

  
}

resource "aws_security_group" "worker" {
  name   = "worker"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports_worker
    content {
      from_port   = port.value
      protocol    = "tcp"
      to_port     = port.value
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  // Terraform removes the default rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "worker_SG"
  }

  
}