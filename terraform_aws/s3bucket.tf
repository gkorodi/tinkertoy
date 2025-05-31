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

resource "aws_s3_bucket" "example" {
  provider      = aws.user
  bucket        = var.s3_bucket_name
  force_destroy = "false" # Will prevent destruction of bucket with contents inside
}
