module "vpc" {
  source = "../../modules/vpc"

  terraform_ap_northeast_3_vpc_cidr = "10.0.0.0/16"
}


module "security_groups" {
  source = "../../modules/security-groups"

  terraform_vpc_id = module.vpc.terraform_ap_northeast_3_vpc_id
}

module "alb" {
  source = "../../modules/alb"

  terraform_vpc_id                = module.vpc.terraform_ap_northeast_3_vpc_id
  terraform_public_subnet_ids     = module.vpc.terraform_ap_northeast_3_public_subnet_ids
  terraform_alb_security_group_id = module.security_groups.terraform_alb_security_group_id
}
# trigger plan
# trigger plan
# trigger plan
