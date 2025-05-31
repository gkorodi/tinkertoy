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

# This Terraform configuration creates a DynamoDB table with the specified attributes and billing mode.
# The table will have a hash key named "employee-id" of type string.
resource "aws_dynamodb_table" "my_first_table" {
  name         = var.table_name
  billing_mode = var.table_billing_mode
  hash_key     = var.hash_key
  attribute {
    name = var.hash_key
    type = var.attribute_type
  }
  tags = {
    environment = "${var.environment}"
  }
}
