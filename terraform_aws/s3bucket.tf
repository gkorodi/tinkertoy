
resource "aws_s3_bucket" "example" {
  provider      = aws.user
  bucket        = var.tinkertoy_s3_bucket_name
  force_destroy = "false" # Will prevent destruction of bucket with contents inside
}
