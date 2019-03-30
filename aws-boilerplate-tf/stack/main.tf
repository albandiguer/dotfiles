provider "aws" {
  region = "${var.aws_region}"
}

# Define a backend
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "aws-boilerplate-remote-tfstate-storage"
    dynamodb_table = "aws-boilerplate-tf-state-lock"
    region         = "ap-southeast-2"
    key            = "aws-boilerplate.tfstate"
    profile        = "default"
  }
}

resource "aws_iam_user" "alban" {
  name = "alban"
}

resource "aws_iam_group" "administrators" {
  name = "administrators"
}

resource "aws_iam_user_group_membership" "alban_admin" {
  user = "${aws_iam_user.alban.name}"

  groups = [
    "${aws_iam_group.administrators.name}",
  ]
}

resource "aws_iam_group_policy" "admin" {
  name = "admin_policy"
  group = "${aws_iam_group.administrators.id}"

  policy=<<EOF
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


