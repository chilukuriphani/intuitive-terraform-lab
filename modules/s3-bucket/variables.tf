variable "s3_bucket_name" {
  description = "The name of the S3 bucket to use as prefix"
}
variable "sse_algorithm" {
  description = "S3 Encryption Algorithm"
  default     = "aws:kms"
}
variable "kms_cmk_arn" {
  description = "The ARN of the KMS CMK to use for encryption"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}


// S3 Lifecycle variables
variable "s3_bucket_enable_object_transition_to_ia" {
  default = "Enabled"
}

variable "s3_bucket_object_transition_to_ia_after_days" {
  default = 90
}

variable "s3_bucket_enable_object_transition_to_glacier" {
  default = "Enabled"
}

variable "s3_bucket_object_transition_to_glacier_after_days" {
  default = 365
}

variable "s3_bucket_enable_object_deletion" {
  default = "Disabled"
}

variable "s3_bucket_object_deletion_after_days" {
  default = 2555
}

variable "s3_force_destroy" {
  default = false
}

variable "s3_versioning" {
  default = true
}

variable "s3_server_access_logging" {
  type = map(any)
  default = {
    target_bucket = ""
    target_prefix = ""
  }
}

variable "bucket_acl" {
  description = "S3 bucket ACL"
  default     = "private"
}
variable "version_state" {
  description = "S3 Version configuartion"
  default     = "Enabled"
}
variable "lifecycle_rules" {
  type    = any
  default = []
}
