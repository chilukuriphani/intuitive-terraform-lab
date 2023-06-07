
####################################################################
##  VPC and Subnets creation
####################################################################
module "lab-vpc" {
  source                 = "./modules/vpc/"
  vpc_cidr               = var.vpc_cidr
  vpc_subnet_list        = var.vpc_subnet_list
  region_name            = var.region_name
  vpc_flowlog_bucket_arn = module.s3-lab.s3_bucket_arn
  master_prefix          = var.master_prefix
  env_prefix             = var.env_prefix
  app_prefix             = var.app_prefix
  vpc_tags               = var.vpc_tags
}

####################################################################
##  S3 bucket creation
####################################################################
module "s3-lab" {
  source          = "./modules/s3-bucket"
  s3_bucket_name  = "terraform-lab-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  kms_cmk_arn     = aws_kms_key.s3_key_prod.arn
  tags            = var.tags
  lifecycle_rules = var.lifecycle_rules
}
resource "aws_s3_bucket_policy" "s3_bucket_policy_prod" {
  bucket = module.s3-lab.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_bucket_policy_prod.json
}

####################################################################
##  Ec2 Instances creation
####################################################################

module "ec2_lab" {
  source             = "./modules/ec2-instance"
  for_each           = local.multiple_instances
  name               = "lab-ec2-${each.key}"
  instance_type      = each.value.instance_type
  availability_zone  = each.value.availability_zone
  subnet_id          = each.value.subnet_id
  enable_volume_tags = false
  root_block_device  = lookup(each.value, "root_block_device", [])
  tags               = var.tags
}

####################################################################
##  KMS Key creation For S3 Bucket
####################################################################
resource "aws_kms_key" "s3_key_prod" {
  description         = "S3 Encryption key"
  key_usage           = "ENCRYPT_DECRYPT"
  enable_key_rotation = true
  tags                = var.tags
  policy              = data.aws_iam_policy_document.s3_key_policy_prod.json
}
resource "aws_kms_alias" "s3_key_alias" {
  name          = "alias/s3-key-alias-prod"
  target_key_id = aws_kms_key.s3_key_prod.key_id
}