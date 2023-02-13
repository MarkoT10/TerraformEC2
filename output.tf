output "instance_ip" {
    value = module.ec2.ec2_public_ip
}

output "instance_tags" {
    value = module.ec2.ec2_tags
}

output "ami_id" {
    value = var.ami_id
}

