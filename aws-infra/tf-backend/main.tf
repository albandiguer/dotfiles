locals {
  /* region = "eu-west-3" */
  region = "ap-southeast-2"
}

# Backend creation with the following module
# https://registry.terraform.io/modules/trussworks/bootstrap/aws/latest
module "bootstrap" {
  source = "trussworks/bootstrap/aws"
  version = "~> 3.0.0"

  region        = local.region
  account_alias = "albandiguer-terraform-state" # https://Your_Account_Alias.signin.aws.amazon.com/console/
}
