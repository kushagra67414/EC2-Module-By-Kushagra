terraform {
  backend "s3" {
    bucket = "ttnbucketone"
    key = "terra.tfstate"
    region = "us-east-1"
    dynamodb_table = "ttnlocking"
  }
}
data "local_file" "user_data_file" {
  filename = var.user_data_filename
}

data "local_file" "policy_file" {
  filename = var.role_policy_filename
}

module "ec2" {
  source = "./modules/ec2/"
  ami_id = var.ami_id
  sg_ingress = var.sg_ingress
  user_data = data.local_file.user_data_file.content
  ec2_role_policy = data.local_file.policy_file.content
}
