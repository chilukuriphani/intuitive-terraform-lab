variable "region_name" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}
variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key"
  type        = string
}
variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Key"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
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
# S3 Configurations
variable "lifecycle_rules" {
  type    = any
  default = []
}
# VPC configurations
variable "vpc_subnet_list" {
  type        = map(map(string))
  description = "Map of subnet information with subnet CIDR"
}

variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type        = string
}
variable "vpc_tags" {
  description = "Additional tags for VPC resources"
  type        = map(string)
}

#######  EC2  #######
variable "lab_instances" {
     description = "Lab ec2 details"
     }