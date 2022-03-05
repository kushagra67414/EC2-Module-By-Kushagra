// Creating AWS IAM Role
resource "aws_iam_role" "my_ec2_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name   = "${var.role_name}Policy"
    policy = var.ec2_role_policy
  }

  managed_policy_arns = var.managed_policy_arns
}

// Creating a AWS IAM Instance Profile
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${aws_iam_role.my_ec2_role.name}InstanceProfile"
  role = aws_iam_role.my_ec2_role.name
}
