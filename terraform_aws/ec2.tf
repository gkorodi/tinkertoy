
resource "aws_security_group" "tinkertoy_sec_group" {
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
    cidr_blocks = [var.tinkertoy_mgmt_ip]
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


resource "aws_instance" "tinkertoy_ec2_instance" {
  ami                         = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID for your region
  instance_type               = "t2.micro"
  provider                    = aws.user
  key_name                    = var.tinkertoy_key_name  # Ensure you have a valid key pair created in your AWS account
  subnet_id                   = var.tinkertoy_subnet_id # Ensure you have a valid subnet ID
  associate_public_ip_address = true
  user_data                   = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > /var/tmp/hello.txt
              EOF
  vpc_security_group_ids      = [aws_security_group.tinkertoy_sec_group.id]
  availability_zone           = "us-west-2a" # Replace with your desired availability zone
  monitoring                  = false
  source_dest_check           = true

  root_block_device {
    volume_size = 8     # Size in GB
    volume_type = "gp2" # General Purpose SSD
  }
  instance_initiated_shutdown_behavior = "terminate"
  disable_api_termination              = false
  tags = {
    Name = "EC2 sec group example"
  }

}
