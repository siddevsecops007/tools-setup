
variable "tools" {
  default = {
    vault = {
      port_no          = 8200
      size_volume      = 20
      instance_type    = "t2.micro"
    }
  }
}

variable "zoneid" {
  default = "Z0839824JM76ZIPWFCGH"
}

variable "domain_name" {
  default = "siddevsecops.icu"
}