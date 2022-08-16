## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.22.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_role"></a> [role](#module\_role) | cloudposse/iam-role/aws | ~> 0.16.2 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.base](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.resource_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | the aws region to create things in | `string` | `"ap-southeast-2"` | no |

## Outputs

No outputs.
