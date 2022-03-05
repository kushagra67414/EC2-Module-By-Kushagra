output "Instance_Public_DNS" {
    value = module.ec2.instance_public_dns
}

output "Instance_Private_DNS" {
    value = module.ec2.instance_private_dns
}