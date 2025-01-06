
variable "tools" {
  default = {
    vault = {
      port_no          = 8200
      size_volume      = 20
      instance_type    = "t3.small"
      policy_list      = ["ec2:DescribeKeyPairs"]
    }
    github-runner = {
      port_no          = 80
      size_volume      = 20
      instance_type    = "t3.small"
      policy_list      = ["ec2:*", "route53:*"]
    }
  }
}

variable "zoneid" {
  default = "Z0839824JM76ZIPWFCGH"
}

variable "domain_name" {
  default = "siddevsecops.icu"
}