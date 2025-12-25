############################################
# ALB Outputs
############################################

output "terraform_alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.terraform_alb.dns_name
}

output "terraform_alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.terraform_alb.arn
}

############################################
# Target Group Outputs
############################################

output "terraform_target_group_arn" {
  description = "Target Group ARN for Auto Scaling Group attachment"
  value       = aws_lb_target_group.terraform_tg.arn
}
