resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name
  tags   = var.tags
  }
# resource "aws_s3_bucket_acl" "bucket_acl" {
#   bucket = aws_s3_bucket.s3_bucket.id
#   acl    = var.bucket_acl
# }
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_cmk_arn
      sse_algorithm     = var.sse_algorithm
    }
  }
}
resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = var.version_state
  }
}
resource "aws_s3_bucket_lifecycle_configuration" "s3_transistion" {
  bucket = aws_s3_bucket.s3_bucket.id
  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {
      id = rule.value.id
      transition {
        days          = rule.value.days
        storage_class = rule.value.sclass
      }
      expiration {
        days          = rule.value.expire
      }
      filter {
        prefix = rule.value.prefix
      }
      status = rule.value.status
    }
  }
}
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}
output "s3_bucket_id" {
  value = aws_s3_bucket.s3_bucket.id
}