############################################
# Application Load Balancer
# - Internet-facing
# - Distributes traffic across targets
############################################
resource "aws_lb" "terraform_alb" {
  name               = "terraform-${var.terraform_project}-${var.terraform_default_environment}-alb"
  load_balancer_type = "application"
  internal           = false

  security_groups = [
    var.terraform_alb_security_group_id
  ]

  subnets = var.terraform_public_subnet_ids

  tags = {
    Name        = "terraform-${var.terraform_project}-${var.terraform_default_environment}-alb"
    Project     = var.terraform_project
    Environment = var.terraform_default_environment
    ManagedBy   = "Terraform"
    Component   = "load-balancer"
    Purpose     = "public-ingress"
  }
}

############################################
# Target Group
# - Receives traffic from ALB
# - Instances will register here later
############################################
resource "aws_lb_target_group" "terraform_tg" {
  name     = "terraform-${var.terraform_project}-${var.terraform_default_environment}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id  = var.terraform_vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "terraform-${var.terraform_project}-${var.terraform_default_environment}-tg"
    Project     = var.terraform_project
    Environment = var.terraform_default_environment
    ManagedBy   = "Terraform"
    Component   = "target-group"
  }
}

############################################
# Listener
# - Listens on port 80
# - Forwards traffic to target group
############################################
resource "aws_lb_listener" "terraform_http_listener" {
  load_balancer_arn = aws_lb.terraform_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terraform_tg.arn
  }
}
