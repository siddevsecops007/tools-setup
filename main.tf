module "tools" {
  for_each = var.tools
  source = "./modules/ec2"
  sg_port = each.value["port_no"]
  tool_name = each.key
  size_volume=each.value["size_volume"]
  instance_type = each.value["instance_type"]
  domain_name = var.domain_name
  zoneid = var.zoneid
  policy_list = each.value["policy_list"]
}



