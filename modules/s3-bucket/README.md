## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.public_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | The account id which wil be used in the S3 bucket name | `any` | n/a | yes |
| kms\_cmk\_arn | The ARN of the KMS CMK to use for encryption | `any` | n/a | yes |
| region | Default region to create the bucket and key | `any` | n/a | yes |
| s3\_bucket\_enable\_object\_deletion | n/a | `bool` | `false` | no |
| s3\_bucket\_enable\_object\_transition\_to\_glacier | n/a | `bool` | `true` | no |
| s3\_bucket\_enable\_object\_transition\_to\_ia | S3 Lifecycle variables | `bool` | `true` | no |
| s3\_bucket\_name | The name of the S3 bucket to use as prefix | `any` | n/a | yes |
| s3\_bucket\_object\_deletion\_after\_days | n/a | `number` | `1095` | no |
| s3\_bucket\_object\_transition\_to\_glacier\_after\_days | n/a | `number` | `365` | no |
| s3\_bucket\_object\_transition\_to\_ia\_after\_days | n/a | `number` | `90` | no |
| s3\_force\_destroy | n/a | `bool` | `false` | no |
| s3\_server\_access\_logging | n/a | `map` | ```{ "target_bucket": "", "target_prefix": "" }``` | no |
| s3\_versioning | n/a | `bool` | `true` | no |
| tags | Specifies object tags key and value. This applies to all resources created by this module. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| s3\_bucket\_arn | The S3 bucket ARN. |
| s3\_bucket\_name | The S3 bucket name. |
