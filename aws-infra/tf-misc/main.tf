locals {
  paris  = "eu-west-3"
  sydney = "ap-southeast-2"
}

provider "aws" {
  region = local.paris
}

# Define the backend (s3 paris)
terraform {
  backend "s3" {
    bucket         = "albandiguer-terraform-state-paris-tf-state-eu-west-3"
    key            = "dotfiles-resources"
    dynamodb_table = "terraform-state-lock"
    region         = "eu-west-3"
    encrypt        = true
  }
}

# Create a role to assume to interact with s3 resources 
data "aws_iam_policy_document" "resource_full_access" {
  statement {
    sid       = "FullAccess"
    effect    = "Allow"
    resources = ["arn:aws:s3:::*"]

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:GetBucketLocation",
      "s3:AbortMultipartUpload"
    ]
    #"s3:DeleteObject",
  }
}

data "aws_iam_policy_document" "base" {
  statement {
    sid       = "BaseAccess"
    effect    = "Allow"
    resources = ["arn:aws:s3:::bucketname"]

    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]
  }
}

# https://registry.terraform.io/modules/cloudposse/iam-role/aws/latest
module "role" {
  source  = "cloudposse/iam-role/aws"
  version = "~> 0.16.2"

  enabled   = true
  namespace = "eg"
  stage     = "prod"
  name      = "app"

  policy_description = "Allow S3 FullAccess minus delete"
  role_description   = "IAM role with permissions to perform actions on S3 resources"

  principals = {}
  # AWS = ["arn:aws:iam::123456789012:role/workers"] # this will be assumed from web? with bitwarden oidc?
  #}

  policy_documents = [
    data.aws_iam_policy_document.resource_full_access.json,
    data.aws_iam_policy_document.base.json
  ]
}
