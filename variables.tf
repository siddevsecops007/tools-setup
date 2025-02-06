
variable "tools" {
  default = {
    vault = {
      port_no          = 8200
      size_volume      = 20
      instance_type    = "t3.small"
      policy_list      = [ ]
    }
    github-runner = {
      port_no          = 80
      size_volume      = 40
      instance_type    = "t3.small"
      policy_list      = ["*"]
    }
  }
}

variable "zoneid" {
  default = "Z0839824JM76ZIPWFCGH"
}

variable "domain_name" {
  default = "siddevsecops.icu"
}