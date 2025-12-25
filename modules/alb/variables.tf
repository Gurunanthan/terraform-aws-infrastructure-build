############################################
# Required inputs
############################################
variable "terraform_vpc_id" {
  description = "VPC ID for ALB"
  type        = string
}

variable "terraform_public_subnet_ids" {
  description = "Public subnet IDs for ALB"
  type        = list(string)
}

variable "terraform_alb_security_group_id" {
  description = "Security group ID for ALB"
  type        = string
}

############################################
# Naming
############################################
variable "terraform_project" {
  type    = string
  default = "aws-infra-build"
}

variable "terraform_default_environment" {
  type    = string
  default = "dev"
}
