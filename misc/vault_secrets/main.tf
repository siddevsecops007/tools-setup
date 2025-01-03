terraform {
  backend "s3" {
    bucket = "terraformpractice007"
    key    = "roboshop-dev/terraform.tfstate"
    region = "us-east-1"
  }
}


provider "vault" {
  address = "http://vault-internal.siddevsecops.icu:8200"
  token   = var.vault_token
  skip_tls_verify = true
}

##comment

variable "vault_token" {}


resource "vault_mount" "roboshop-dev" {
  path        = "roboshop-dev"
  type        = "kv"
  options     = { version = "2" }
  description = "RoboShop Dev Secrets"
}


# resource "vault_generic_secret" "roboshop-dev" {
#   path = "${vault_mount.roboshop-dev.path}/frontend"
#
#   data_json = <<EOT
# {
#   "foo":   "bar",
#   "pizza": "cheese"
# }
# EOT
# }

resource "vault_generic_secret" "frontend" {
  path = "${vault_mount.roboshop-dev.path}/frontend"
  data_json = <<EOT
  {
    "catalogue_url":   "http://catalogue-dev.siddevsecops.icu:8080/",
    "user_url":   "http://user-dev.siddevsecops.icu:8080/",
    "cart_url":   "http://cart-dev.siddevsecops.icu:8080/",
    "shipping_url":   "http://shipping-dev.siddevsecops.icu:8080/",
    "payment_url":   "http://payment-dev.siddevsecops.icu:8080/"

  }
  EOT
}

resource "vault_generic_secret" "catalogue" {
  path = "${vault_mount.roboshop-dev.path}/catalogue"
  data_json = <<EOT
  {
    "MONGO": "true",
    "MONGO_URL": "mongodb://mongodb-dev.siddevsecops.icu:27017/catalogue"
  }
  EOT
}