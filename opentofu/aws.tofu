resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

data "aws_vpc" "example" {
  id = "vpc-id"
}

resource "aws_subnet" "example" {
  vpc_id     = data.aws_vpc.example.id
  cidr_block = "10.0.1.0/24"
}

output "vpc_id" {
  value       = aws_vpc.example.id
  description = "The VPC ID"
}

variable "cidr_block" {
  type        = string
  description = "The VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "vpc_details" {
  type        = map(string)
  description = "The VPC details"
  default     = {
    "name" = "vpc1"
    "cidr" = "10.0.0.0/16"
  } 
}
