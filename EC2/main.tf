#block to creates ec2 instance
resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.instance
  key_name                    = var.key_name
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.vpc_security_group_ids]

  tags = {
    Name = "EC2_t2Micro"
  }
}