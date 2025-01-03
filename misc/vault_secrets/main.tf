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


resource "vault_generic_secret" "user" {
path = "${vault_mount.roboshop-dev.path}/user"
data_json = <<EOT
  {
    "MONGO": "true",
    "REDIS_URL":  "redis://redis-dev.siddevsecops.icu:6379",
    "MONGO_URL":  "mongodb://mongodb-dev.siddevsecops.icu:27017/users"
  }
  EOT
}
resource "vault_generic_secret" "cart" {
  path = "${vault_mount.roboshop-dev.path}/cart"
  data_json = <<EOT
  {
    "REDIS_HOST": "redis-dev.siddevsecops.icu",
    "CATALOGUE_HOST":  "catalogue-dev.siddevsecops.icu",
    "CATALOGUE_PORT":  "8080"
  }
  EOT
}

resource "vault_generic_secret" "shipping" {
  path = "${vault_mount.roboshop-dev.path}/shipping"
  data_json = <<EOT
  {
    "User": "roboshop",
    "CART_ENDPOINT":  "cart-dev.siddevsecops.icu:8080",
    "DB_HOST":  "mysql-dev.siddevsecops.icu",
    "mysql_root_password":  "Roboshop@1"
  }
  EOT
}

resource "vault_generic_secret" "payment" {
  path = "${vault_mount.roboshop-dev.path}/payment"
  data_json = <<EOT
  {
    "CART_HOST": "cart-{{ env }}.siddevsecops.icu",
    "CART_PORT":  "8080",
    "USER_HOST":  "user-{{ env }}.siddevsecops.icu",
    "USER_PORT":  "8080",
    "AMQP_HOST":  "rabbitmq-{{ env }}.siddevsecops.icu",
    "AMQP_USER":  "roboshop",
    "AMQP_PASS":  "roboshop123"

  }
  EOT
}


resource "vault_generic_secret" "mysql" {
  path = "${vault_mount.roboshop-dev.path}/mysql"
  data_json = <<EOT
  {
    "mysql_root_password":  "Roboshop@1"
  }
  EOT
}

resource "vault_generic_secret" "rabbitmq" {
  path = "${vault_mount.roboshop-dev.path}/rabbitmq"
  data_json = <<EOT
  {
    "rabbitMQ_user":  "roboshop",
    "rabbitMQ_password":  "roboshop123"

  }
  EOT
}


resource "vault_mount" "infra_secrets" {
  path        = "infra_secrets"
  type        = "kv"
  options     = { version = "2" }
  description = "Common infra secrets"
}


resource "vault_generic_secret" "ssh" {
  path = "${vault_mount.infra_secrets.path}/ssh"
  data_json = <<EOT
  {
    "username": "ec2-user",
    "password": "DevOps321"

  }
  EOT
}

