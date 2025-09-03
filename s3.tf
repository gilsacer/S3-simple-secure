
#### S3 Bucket teste ####
resource "aws_s3_bucket" "s3-teste-dev-tf-2025" {
  bucket = "terraform-${data.aws_caller_identity.current.account_id}-dev"

  tags = {
    Description = "Bucket teste"
    Enviroment  = "Dev"
    ManagedBy   = "Terraform"
    Owner       = "Infra-IAC"
    CreatedAt   = "2025-09-03"
  }
}

#### S3 Bucket Versioning ####
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.s3-teste-dev-tf-2025.id
  versioning_configuration {
    status = "Disabled"
  }
}

#### S3 Bucket Server Side Encryption ####
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.s3-teste-dev-tf-2025.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#### S3 Bucket Public Access Block ####
resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket = aws_s3_bucket.s3-teste-dev-tf-2025.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#### S3 Bucket Policy ####
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3-teste-dev-tf-2025.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyInsecureConnections"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource  = "${aws_s3_bucket.s3-teste-dev-tf-2025.arn}/*"
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

