module "vpc" {
  source = "../../modules/vpc"

  terraform_ap_northeast_3_vpc_cidr = "10.0.0.0/16"
}
