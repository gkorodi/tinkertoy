provider "aws" {
  alias   = "user"
  region  = var.region
  profile = var.profile
}

# This Terraform configuration creates a DynamoDB table with the specified attributes and billing mode.
# The table will have a hash key named "employee-id" of type string.
resource "aws_dynamodb_table" "my_first_table" {
  name         = var.dynadb_tinkertoy_table_name
  billing_mode = var.dynadb_tinkertoy_billing_mode # The billing mode can be either PAY_PER_REQUEST or PROVISIONED.
  # read_capacity  = var.dynadb_read_capacity # this can not be set when billing_mode is "PAY_PER_REQUEST"
  # write_capacity = var.dynadb_write_capacity # this can not be set when billing_mode is "PAY_PER_REQUEST"
  provider = aws.user
  # The provider is set to use the AWS profile and region specified in the variables.
  # The table will be created in the specified AWS region and profile.

  hash_key = var.dynadb_tinkertoy_hash_key
  attribute {
    name = var.dynadb_tinkertoy_hash_key
    type = var.dynadb_hashkey_attribute_type
  }

  tags = {
    Environment = var.environment
    Name        = var.dynadb_tinkertoy_table_name
    CreatedBy   = "OpenTofu"
  }
  # Tags are added to the DynamoDB table for identification and management purposes.


  # Provisioned throughput settings are only required if billing mode is PROVISIONED
}
