#### main.tf
provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.app_name}-remote-tfstate-storage"

  lifecycle {
    prevent_destroy = true
  }
}


resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "${var.app_name}-tf-state-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Backend creation with the following module 
# https://registry.terraform.io/modules/trussworks/bootstrap/aws/latest 
module "bootstrap" {
  source = "trussworks/bootstrap/aws"

  region        = var.aws.region
  account_alias = "account-alban"
}
