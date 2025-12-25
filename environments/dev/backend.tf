terraform {
  backend "s3" {
    bucket         = "thisbucketismainlyusedforterraformbackend"
    key            = "dev/terraform.tfstate"
    region         = "ap-northeast-3"
    dynamodb_table = "terraform-aws-infra-locks"
    encrypt        = true
  }
}
