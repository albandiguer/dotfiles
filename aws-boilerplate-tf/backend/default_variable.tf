# default_variables.tf

variable "app_name" {
  type        = string
  description = "A unique site name for allocation of resources"
  default     = "aws-boilerplate"
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-2"
}
