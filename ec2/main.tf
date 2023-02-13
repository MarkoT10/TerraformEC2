resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance
  count         = var.instance_count
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "ProjectServerInstance ${count.index + 1}"
  }
}