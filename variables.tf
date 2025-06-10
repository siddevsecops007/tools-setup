
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
      size_volume      = 50
      instance_type    = "t3.small"
      policy_list      = ["*"]
    }
  }
}

variable "zoneid" {
  #default = "Z0949039285DH1J81BA7"
  default = "Z09554111AOE4XJPNZU5J"
}

variable "domain_name" {
  default = "siddevsecops.icu"
}