variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}
variable "table_billing_mode" {
  description = "The billing mode for the DynamoDB table (e.g., PAY_PER_REQUEST, PROVISIONED)"
  type        = string
  default     = "PAY_PER_REQUEST"
}
variable "region" {
  description = "The AWS region where the DynamoDB table will be created"
  type        = string
  default     = "us-west-2"
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
variable "tags" {
  description = "Additional tags to apply to the DynamoDB table"
  type        = map(string)
  default     = {}
}
variable "hash_key" {
  description = "The hash key for the DynamoDB table"
  type        = string
  default     = "employee-id"
}
variable "attribute_type" {
  description = "The type of the attribute for the hash key (e.g., S for string, N for number)"
  type        = string
  default     = "S"
}
variable "read_capacity" {
  description = "The read capacity units for the DynamoDB table (only for PROVISIONED billing mode)"
  type        = number
  default     = 5
}
variable "write_capacity" {
  description = "The write capacity units for the DynamoDB table (only for PROVISIONED billing mode)"
  type        = number
  default     = 5
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to be created"
  type        = string
  default     = "my-example-bucket"

}

variable "mgmt_ip" {
  description = "The management IP address for SSH access"
  type        = string
  default     = "0.0.0/0" # Replace with your actual management IP address or CIDR block
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the EC2 instance"
  type        = string
  default     = "my-key-pair" # Replace with your actual key pair name
}
variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be launched"
  type        = string
  default     = "subnet-12345678" # Replace with your actual subnet ID
}
variable "instance_type" {
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
