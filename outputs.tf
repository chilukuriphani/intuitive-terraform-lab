output "s3_bucket_id" {
  value       = module.s3-lab.s3_bucket_name
  description = "S3 Bucket ID"
}