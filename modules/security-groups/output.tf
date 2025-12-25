output "terraform_alb_security_group_id" {
  description = "ALB Security Group ID"
  value       = aws_security_group.terraform_alb_sg.id
}

output "terraform_ec2_security_group_id" {
  description = "EC2 Security Group ID"
  value       = aws_security_group.terraform_ec2_sg.id
}
