#### main.tf
provider "aws" {
  region  = var.aws_region
  profile = "root"
  version = "~> 4.22.0"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.app_name}-remote-tfstate-storage"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
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
