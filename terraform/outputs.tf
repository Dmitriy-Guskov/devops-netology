output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}
output "instance_ami" {
  description = "AMI of the EC2 instance"
  value       = aws_instance.app_server.ami
}

output "instance_arn" {
  description = "ARN the EC2 instance"
  value       = aws_instance.app_server.arn
}
output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.app_server.private_ip
}

output "instance_network_id" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.app_server.subnet_id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "region" {
  value = var.aws_region
}
