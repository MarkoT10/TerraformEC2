data "aws_ami" "latest_linux_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  owners = ["amazon"]
}

variable "ami_id" {
  type    = string
  default = data.aws_ami.latest_linux_ami.id
}

variable "instance" {
  type    = string
  default = "t2.micro"
}

variable "instance_count" {
  type    = number
  default = 1
}

# Define a variable for the security group ID
variable "security_group_id" {
  type = string
}

# Create a security group to control incoming and outgoing traffic
resource "aws_security_group" "app_server_security_group" {
  name        = "app-server-security-group"
  description = "Allow HTTP and SSH access to the app servers"

  # Allow incoming SSH traffic from any IP address
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow incoming HTTP traffic from any IP address
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to any IP address
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
