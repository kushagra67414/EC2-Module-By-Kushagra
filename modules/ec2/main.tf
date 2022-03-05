// Provider Requirements
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.48.0"
    }
  }
}

// Getting VPC Data
data "aws_vpc" "default" {
  filter {
    name = "isDefault"
    values = ["true"]
  }
}
