
# Step 2: Create a key pair (optional)
resource "aws_key_pair" "tinkertoy_keypair" {
  key_name   = "tinkerto_key"
  public_key = file("~/.ssh/tinkertoy_private_key") # Make sure to have an existing SSH key here
}

# Step 3: Define the security group for the instance
resource "aws_security_group" "tinkertoy_machine_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (not recommended for production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Step 4: Define the EC2 instance
resource "aws_instance" "tinkertoy_ec2_machine" {
  ami           = "ami-0abcdef1234567890" # Replace with a valid AMI ID from your region
  instance_type = "t2.micro"

  key_name                    = aws_key_pair.tinkertoy_keypair.key_name
  security_groups             = [aws_security_group.tinkertoy_machine_sg.name]
  associate_public_ip_address = true
  availability_zone           = var.region                     # Replace with your desired availability zone
  subnet_id                   = var.tinkertoy_subnet_id        # Replace with your subnet ID
  user_data                   = file("tinkertoy_user_data.sh") # Path to your user data script

  instance_initiated_shutdown_behavior = "terminate"
  disable_api_termination              = false
  monitoring                           = false
  source_dest_check                    = true
  iam_instance_profile                 = "your-iam-role" # Replace with your IAM role if needed
  root_block_device {
    volume_size = 8     # Size in GB
    volume_type = "gp2" # General Purpose SSD
  }
  ebs_optimized = false
  credit_specification {
    cpu_credits = "standard"
  }
  metadata_options {
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  tags = {
    Name        = "tinkertoy_ec2_machine"
    Environment = var.environment
    Project     = "Tinkertoy"
  }
}
