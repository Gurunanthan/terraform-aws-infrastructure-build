output "terraform_alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.terraform_alb.dns_name
}

output "terraform_target_group_arn" {
  description = "Target group ARN for ASG attachment"
  value       = aws_lb_target_group.terraform_tg.arn
}
