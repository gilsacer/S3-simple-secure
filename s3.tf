data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "my-teste-bucket-2025" {
  bucket = "teste-${data.aws_caller_identity.current.account_id}"

  tags = {
    Description = "Bucket teste"
    Enviroment  = "Dev"
    ManagedBy   = "Terraform"
    Owner       = "Infra-IAC"
    CreatedAt   = "2025-07-11"
  }
}

resource "aws_s3_bucket_versioning" "my-teste-bucket-2025" {
  bucket = aws_s3_bucket.my-teste-bucket-2025.id
  versioning_configuration {
    status = "Disabled"
  }
}


