variable "terraform-backend-bucket-name"{
    description = "This is for the name of the backend bucket"
    type = string
    default = ""
}
variable "terrafrom-backend-key"{
    description = "this is for the terraform backend key"
    type = string
    default = "dev/terraform.tfstate"
}
variable "terraform-default-region"{
    description = "It is going to be the default region for every resource created"
    type = string
    default = "ap-northeast-3"
}


