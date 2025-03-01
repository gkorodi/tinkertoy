# Step 1: Define the provider for AWS
provider "aws" {
  region = "us-east-1" # Define the AWS region where you want to launch the EC2 instance
}

# Step 2: Create a key pair (optional)
resource "aws_key_pair" "bu_spark_hackathon_key" {
  key_name   = "bu_spark_hackathon_key"
  public_key = file("~/.ssh/bu_spark_hackathon_private_key") # Make sure to have an existing SSH key here
}

# Step 3: Define the security group for the instance
resource "aws_security_group" "allow_ssh" {
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
resource "aws_instance" "bu-spark-demo" {
  ami           = "ami-0abcdef1234567890" # Replace with a valid AMI ID from your region
  instance_type = "t2.micro"

  key_name               = aws_key_pair.bu_spark_hackathon_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "buSparkDemo"
  }
}