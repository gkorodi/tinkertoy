resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

data "aws_vpc" "example" {
  id = "vpc-id"
}

resource "aws_subnet" "example" {
  vpc_id     = data.aws_vpc.example.id
  cidr_block = "10.0.1.0/24"
  …
}
