#block to creates ec2 instance
resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.instance
  key_name                    = var.key_name
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.vpc_security_group_ids]

  tags = {
    Name = var.name
  }
}

# # Configure the Docker provider
# provider "docker" {
#   host = "tcp://127.0.0.1:2376/"
# }

# # Create a container
# resource "docker_container" "foo" {
#   image = "${docker_image.ubuntu.latest}"
#   name  = "foo"
# }

# resource "docker_image" "ubuntu" {
#   name = "ubuntu:latest"
# }
