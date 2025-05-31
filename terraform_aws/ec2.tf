terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  alias   = "user"
  region  = var.region
  profile = var.profile
}

resource "aws_security_group" "instance" {
  name        = "tf-test"
  description = "Security group for EC2 instance"
  tags = {
    Name = "EC2EXAMPLE"
  }

  # Inbound SSH from management ip
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.mgmt_ip]
  }

  # Outbound web for package downloading
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound web for package downloading
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "example" {
  ami                         = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID for your region
  instance_type               = "t2.micro"
  provider                    = aws.user
  key_name                    = var.key_name  # Ensure you have a valid key pair created in your AWS account
  subnet_id                   = var.subnet_id # Ensure you have a valid subnet ID
  associate_public_ip_address = true
  user_data                   = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > /var/tmp/hello.txt
              EOF
  vpc_security_group_ids      = [aws_security_group.instance.id]
  tags = {
    Name = "EC2 sec group example"
  }

}
