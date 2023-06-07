data "aws_availability_zones" "available" {}

locals {
  subnet_full_list = flatten([
    for subnet_name in keys(var.vpc_subnet_list) : [
      for key, value in var.vpc_subnet_list[subnet_name] : {
        # "subnet_name" = substr(subnet_name, 3, -1)
        "subnet_name" = subnet_name
        "cidr"        = value
        "az"          = key
      }
    ]
  ])
  subnet_names_list = keys(var.vpc_subnet_list)
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = merge(
    {
      "Name" = format("%s-%s-%s-vpc", var.master_prefix, var.env_prefix, var.app_prefix)
    },
    var.tags, var.vpc_tags
  )
}

resource "aws_subnet" "subnets" {
  count             = length(local.subnet_full_list)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = local.subnet_full_list[count.index].cidr
  availability_zone = format("%s%s", var.region_name, local.subnet_full_list[count.index].az)

  tags = merge(
    {
      "Name"       = format("%s-subnet-%s", local.subnet_full_list[count.index].subnet_name, local.subnet_full_list[count.index].az),
      "SubnetName" = local.subnet_full_list[count.index].subnet_name
    },
    var.tags, var.vpc_tags
  )
}

// VPC Flow Log (S3)
resource "aws_flow_log" "example" {
  log_destination      = var.vpc_flowlog_bucket_arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.vpc.id
  tags = merge(
    {
      "Name" = format("%s-%s-%s-flowlog-s3", var.master_prefix, var.env_prefix, var.app_prefix)
    },
    var.tags, var.vpc_tags
  )
}

// VPC Flow Log (CloudWatch LogGroup)
resource "aws_flow_log" "fl" {
  iam_role_arn    = aws_iam_role.vpc_flowlog_role.arn
  log_destination = aws_cloudwatch_log_group.cw_loggroup_for_vpc_flowlog.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.vpc.id
  tags = merge(
    {
      "Name" = format("%s-%s-%s-flowlog-cw", var.master_prefix, var.env_prefix, var.app_prefix)
    },
    var.tags, var.vpc_tags
  )
}

resource "aws_cloudwatch_log_group" "cw_loggroup_for_vpc_flowlog" {
  #checkov:skip=CKV_AWS_158:KMS Encryption is not enabled
  name              = format("%s-%s-%s-vpc-flowlog", var.master_prefix, var.env_prefix, var.app_prefix)
  retention_in_days = 180
}

resource "aws_iam_role" "vpc_flowlog_role" {
  name = format("%s-%s-%s-vpc-flowlog-role", var.master_prefix, var.env_prefix, var.app_prefix)

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "vpc-flow-logs.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "vpc_flowlog_policy" {
  name = format("%s-%s-%s-vpc-flowlog-policy", var.master_prefix, var.env_prefix, var.app_prefix)
  role = aws_iam_role.vpc_flowlog_role.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}
