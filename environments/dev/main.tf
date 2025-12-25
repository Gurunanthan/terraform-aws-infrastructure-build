module "vpc" {
  source = "../../modules/vpc"

  terraform_ap_northeast_3_vpc_cidr = "10.0.0.0/16"
}


module "security_groups" {
  source = "../../modules/security-groups"

  terraform_vpc_id = module.vpc.terraform_ap_northeast_3_vpc_id
}
