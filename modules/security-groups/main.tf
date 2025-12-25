############################################
# ALB Security Group
# - Allows inbound traffic from the internet
# - Only HTTP (80) for now
############################################
resource "aws_security_group" "terraform_alb_sg" {
  name        = "terraform-${var.terraform_project}-${var.terraform_default_environment}-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.terraform_vpc_id

  # Inbound HTTP from anywhere
  ingress {
    description = "Allow HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic allowed to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "terraform-${var.terraform_project}-${var.terraform_default_environment}-alb-sg"
    Project     = var.terraform_project
    Environment = var.terraform_default_environment
    ManagedBy   = "Terraform"
    Component   = "security-group"
    Purpose     = "alb-ingress"
  }
}

############################################
# EC2 / ASG Security Group
# - Allows traffic ONLY from ALB SG
# - No public internet access
############################################
resource "aws_security_group" "terraform_ec2_sg" {
  name        = "terraform-${var.terraform_project}-${var.terraform_default_environment}-ec2-sg"
  description = "Security group for EC2 instances behind ALB"
  vpc_id      = var.terraform_vpc_id

  # Allow traffic ONLY from ALB
  ingress {
    description     = "Allow HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.terraform_alb_sg.id]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "terraform-${var.terraform_project}-${var.terraform_default_environment}-ec2-sg"
    Project     = var.terraform_project
    Environment = var.terraform_default_environment
    ManagedBy   = "Terraform"
    Component   = "security-group"
    Purpose     = "ec2-backend"
  }
}
