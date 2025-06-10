terraform {
  backend "s3" {
#    bucket = "terraformpractice007"
#    bucket = "sidterraformpractice007"
    bucket = "terraformsiddevsecops001"
    key    = "tools/terraform.tfstate"
    region = "us-east-1"
  }
}