terraform {
  backend "s3" {
    bucket                  = "eks-terraformstate"
    region                  = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    key                     = "terraform.tfstate"
    encrypt                 = true
  }
}
