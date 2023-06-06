variable "region_name" {
  type = string
}

variable "vpc_subnet_list" {
  type        = map(map(string))
  description = "Map of subnet information with subnet CIDR, name and AZ"
}

variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type        = string
}

variable "vpc_flowlog_bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket used to store VPC Flow Logs"
}

variable "master_prefix" {
  description = "Master Prefix for all AWS Resources"
  type        = string
}

variable "env_prefix" {
  description = "Environment Prefix for all AWS Resources"
  type        = string
}

variable "app_prefix" {
  description = "Application Prefix for all AWS Resources"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for VPC resources"
  type        = map(string)
}