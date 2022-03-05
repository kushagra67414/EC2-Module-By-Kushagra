output "instance_public_dns" {
    value = aws_instance.instance.public_dns
}

output "instance_private_dns" {
    value = aws_instance.instance.private_dns
}
