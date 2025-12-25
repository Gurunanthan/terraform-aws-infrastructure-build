terraform {
  backend "s3" {
    bucket         = "thisbucketismainlyusedforterraformbackend"
    key            = "dev/terraform.tfstate"
    region         = "ap-northeast-3"
    encrypt        = true
  }
}
