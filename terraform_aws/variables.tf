variable "dynadb_tinkertoy_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "tinkertoy-measurement-table" # If you don't provide a default value, the `plan` command will prompt you to enter a value.
  # Ensure the table name is unique within your AWS account and region.
  # DynamoDB table names must be between 3 and 255 characters long and can only contain alphanumeric characters, underscores, hyphens, and periods.
  # The table name must be unique within your AWS account and region.
  validation {
    condition     = length(var.dynadb_tinkertoy_table_name) > 0
    error_message = "The DynamoDB table name must not be empty."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]+$", var.dynadb_tinkertoy_table_name))
    error_message = "The DynamoDB table name can only contain alphanumeric characters, underscores, hyphens, and periods."
  }
  validation {
    condition     = length(var.dynadb_tinkertoy_table_name) <= 255
    error_message = "The DynamoDB table name must be 255 characters or less."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]+$", var.dynadb_tinkertoy_table_name))
    error_message = "The DynamoDB table name can only contain alphanumeric characters, underscores, hyphens, and periods."
  }
}
variable "dynadb_tinkertoy_billing_mode" {
  description = "The billing mode for the DynamoDB table (e.g., PAY_PER_REQUEST, PROVISIONED)"
  type        = string
  default     = "PAY_PER_REQUEST"

  validation {
    condition     = contains(["PAY_PER_REQUEST", "PROVISIONED"], var.dynadb_tinkertoy_billing_mode)
    error_message = "Billing mode must be either PAY_PER_REQUEST or PROVISIONED."
  }
}
variable "region" {
  description = "The AWS region where the DynamoDB table will be created"
  type        = string
  default     = "us-east-1"
}
variable "profile" {
  description = "The AWS profile to use for authentication"
  type        = string
  default     = "default"
}
variable "environment" {
  description = "The environment for the DynamoDB table (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "dynadb_tinkertoy_hash_key" {
  description = "The hash key for the DynamoDB table"
  type        = string
  default     = "employee-id"
}
variable "dynadb_hashkey_attribute_type" {
  description = "The type of the attribute for the hash key (e.g., S for string, N for number)"
  type        = string
  default     = "S"
}
variable "dynadb_read_capacity" {
  description = "The read capacity units for the DynamoDB table (only for PROVISIONED billing mode)"
  type        = number
  default     = 5
}
variable "dynadb_write_capacity" {
  description = "The write capacity units for the DynamoDB table (only for PROVISIONED billing mode)"
  type        = number
  default     = 5
}

variable "tinkertoy_s3_bucket_name" {
  description = "The name of the S3 bucket to be created"
  type        = string
  default     = "my-example-bucket"

}

variable "tinkertoy_mgmt_ip" {
  description = "The management IP address for SSH access"
  type        = string
  default     = "0.0.0.0/0" # Replace with your actual management IP address or CIDR block

  validation {
    condition     = can(cidrhost(var.tinkertoy_mgmt_ip, 0))
    error_message = "The management IP must be a valid CIDR block (e.g., 192.168.1.0/24)."
  }
}

variable "tinkertoy_key_name" {
  description = "The name of the SSH key pair to use for the EC2 instance"
  type        = string
  default     = "my-key-pair" # Replace with your actual key pair name
}
variable "tinkertoy_subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be launched"
  type        = string
  default     = "subnet-12345678" # Replace with your actual subnet ID
}
variable "tinkertoy_instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro" # Replace with your desired instance type
}
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID for your region
}
variable "vpc_id" {
  description = "The ID of the VPC where the EC2 instance will be launched"
  type        = string
  default     = "vpc-12345678" # Replace with your actual VPC ID
}
variable "security_group_name" {
  description = "The name of the security group for the EC2 instance"
  type        = string
  default     = "tf-test"
}
variable "security_group_description" {
  description = "The description of the security group for the EC2 instance"
  type        = string
  default     = "Security group for EC2 instance"
}
variable "force_destroy" {
  description = "Whether to force destroy the S3 bucket even if it contains objects"
  type        = bool
  default     = false
}
variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "example-project"
  }
}
