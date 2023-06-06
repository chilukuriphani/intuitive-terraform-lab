output "s3_bucket_name" {
  description = "The S3 bucket name."
  value       = aws_s3_bucket.s3_bucket.id
}

output "s3_bucket_arn" {
  description = "The S3 bucket ARN."
  value       = aws_s3_bucket.s3_bucket.arn
}