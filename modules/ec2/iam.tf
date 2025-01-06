resource "aws_iam_role" "role" {
  count = length(var.policy_list) > 0 ? 1 : 0
  name = "${var.tool_name}-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    name = "my_inline_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = var.policy_list
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }

  tags = {
    name = "${var.tool_name}-role"
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  count = length(var.policy_list) > 0 ? 1 : 0
  name = "${var.tool_name}-role"
  role = aws_iam_role.role[0].name
}


