# ---------------------------------------------------------------------------------------
# AWS
# ---------------------------------------------------------------------------------------
provider "aws" {
  region = var.region_name
  alias  = "aws-intutive"
  assume_role {
    role_arn = "arn:aws:iam::413909889773:role/TerraformExecutionRole"
  }
  default_tags {
    tags = var.tags
  }
}
# ---------------------------------------------------------------------------------------
# Terraform
# ---------------------------------------------------------------------------------------
terraform {
  required_version = ">= 1.1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.15.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.11.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.5.1"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.1"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1"
    }
  }
  /*
  // Terraform Backend
  backend "s3" {
    region         = "us-east-1"
    encrypt        = true
    bucket         = "tfstate-us-east-1"
    key            = "lab/terraform.tfstate"
    dynamodb_table = "lab-tf-state-lock"
  }
  */
}
