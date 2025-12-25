provider "aws" {
  region = "ap-northeast-3"
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr = "10.0.0.0/16"

  tags = {
    Project = "terraform-aws-infrastructure-build"
    Env     = "dev"
  }
}
