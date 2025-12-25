############################################
# VPC ID
############################################
variable "terraform_vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

############################################
# Project & Environment
############################################
variable "terraform_project" {
  type    = string
  default = "aws-infrastructure-build"
}

variable "terraform_default_environment" {
  type    = string
  default = "dev"
}
