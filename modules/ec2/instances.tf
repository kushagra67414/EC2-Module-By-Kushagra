// Creating Key
resource "tls_private_key" "tls_key" {
  algorithm = "RSA"
}

// Generating Key-Value Pair
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = "${tls_private_key.tls_key.public_key_openssh}"

  depends_on = [
    tls_private_key.tls_key
  ]
}

// Saving Private Key PEM File
resource "local_file" "key_file" {
  content  = "${tls_private_key.tls_key.private_key_pem}"
  filename = "${var.key_name}.pem"

  depends_on = [
    tls_private_key.tls_key
  ]
}

// Creating Security Group
resource "aws_security_group" "inst_sg" {
  name        = var.sg_name
  description = "Security Group for Instance"
  vpc_id      = var.vpc_id == null ? data.aws_vpc.default.id : var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_ingress
    content {
      description      = ingress.value.description
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      self             = ingress.value.self
      cidr_blocks      = ingress.value.cidr_blocks
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
      security_groups  = ingress.value.security_groups
    }
  }

  dynamic "egress" {
    for_each = var.sg_egress
    content {
      description      = egress.value.description
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      self             = egress.value.self
      cidr_blocks      = egress.value.cidr_blocks
      ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
      security_groups  = egress.value.security_groups
    }
  }
}

// Launching an Instance
resource "aws_instance" "instance" {
  ami           = var.ami_id
  instance_type = var.inst_type
  key_name = aws_key_pair.generated_key.key_name
  security_groups = [aws_security_group.inst_sg.name]
  disable_api_termination = var.instance_termination_protection
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  user_data = var.user_data

  tags = {
    Name = "Ec2ModuleInstance"
  }
}
