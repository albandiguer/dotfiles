provider "aws" {
  region = var.aws_region
}

# Backend stored in s3
# not worth it as opposed to local + github checkin
terraform {
  backend "s3" {
    bucket         = "albandiguer-terraform-state-tf-state-ap-southeast-2"
    key            = "dotfiles-resources"
    dynamodb_table = "terraform-state-lock"
    region         = "ap-southeast-2"
    encrypt        = true
  }
}

resource "aws_iam_user" "alban" {
  name = "alban"
}

resource "aws_iam_group" "administrators" {
  name = "administrators"
}

resource "aws_iam_user_group_membership" "alban_admin" {
  user = aws_iam_user.alban.name

  groups = [
    aws_iam_group.administrators.name,
  ]
}

resource "aws_iam_group_policy" "admin" {
  name  = "admin_policy"
  group = aws_iam_group.administrators.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1544790092768",
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
