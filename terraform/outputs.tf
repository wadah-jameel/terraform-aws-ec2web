output "instance_ids" {
  description = "IDs of created EC2 instances"
  value       = aws_instance.web[*].id
}

output "instance_public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = aws_instance.web[*].public_ip
}

output "instance_public_dns" {
  description = "Public DNS names of EC2 instances"
  value       = aws_instance.web[*].public_dns
}

output "website_urls" {
  description = "URLs to access the websites"
  value       = [for instance in aws_instance.web : "http://${instance.public_ip}"]
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_sg.id
}

output "ssm_connection_commands" {
  description = "Commands to connect via AWS Systems Manager"
  value = [for instance in aws_instance.web : 
    "aws ssm start-session --target ${instance.id} --region ${var.aws_region}"
  ]
}
