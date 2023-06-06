data "aws_availability_zones" "available" {}

data "aws_region" "current" {}



data "aws_caller_identity" "current" {}

############ KMS Key Policy for S3 ############

data "aws_iam_policy_document" "s3_key_policy_prod" {
  statement {
    sid    = "Allow access for all principals in the account that are authorized"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:CreateGrant",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
  statement {
    sid    = "Allow root users to do all operations"
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
  }
}

############ S3 Bucket Policy ############

data "aws_iam_policy_document" "s3_bucket_policy_prod" {
  statement {
    sid    = "AllowSSLRequestsOnly"
    effect = "Deny"
    actions = ["s3:*"
    ]
    resources = [
      "arn:aws:s3:::terraform-lab-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}",
      "arn:aws:s3:::terraform-lab-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}