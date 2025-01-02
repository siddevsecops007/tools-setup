terraform {
  backend "s3" {
    bucket = "terraformpractice007"
    key    = "tools/terraform.tfstate"
    region = "us-east-1"
  }
}