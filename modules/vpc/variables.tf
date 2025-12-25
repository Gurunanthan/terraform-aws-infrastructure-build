variable "terraform_project" {
  description = "Project identifier used for naming resources"
  type        = string
  default     = "aws-infrastructure-build"
}

variable "terraform_default_environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "terraform_ap_northeast_3_vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "terraform_ap_northeast_3_vpc_tags" {
  description = "Additional tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "terraform_ap_northeast_3_vpc_metadata" {
  description = "Metadata object for VPC naming and tagging"
  type = object({
    project     = string
    environment = string
    extra_tags  = map(string)
  })

  default = {
    project     = "aws-infra-build"
    environment = "dev"
    extra_tags  = {}
  }
}
variable "terraform_ap_northeast_3_public_subnet_cidrs" {
  description = "Public subnet CIDRs for ap-northeast-3"
  type        = list(string)
  default     = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "terraform_ap_northeast_3_public_subnet_azs" {
  description = "Availability zones for public subnets"
  type        = list(string)
  default     = [
    "ap-northeast-3a",
    "ap-northeast-3b"
  ]
}
output "terraform_ap_northeast_3_public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.terraform_ap_northeast_3_public[*].id
}

