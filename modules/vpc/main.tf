############################################
# VPC
# - Acts as the network boundary
# - Enables internal DNS resolution
# - DOES NOT provide internet access by itself
############################################
resource "aws_vpc" "terraform_ap_northeast_3_vpc" {
  cidr_block           = var.terraform_ap_northeast_3_vpc_cidr
  enable_dns_support   = true   # Allows DNS resolution inside the VPC
  enable_dns_hostnames = true   # Required for ALB / EC2 DNS names

  tags = merge(
    {
      # Human-readable name in AWS Console
      Name = "terraform-${var.terraform_project}-${var.terraform_default_environment}-vpc"
    },
    # Optional user-defined tags (team, cost, owner, etc.)
    var.terraform_ap_northeast_3_vpc_tags,
    # Extra metadata tags (flexible extension point)
    var.terraform_ap_northeast_3_vpc_metadata.extra_tags
  )
}

############################################
# Internet Gateway (IGW)
# - Provides a path between VPC and the internet
# - REQUIRED for public subnets
# - DOES NOTHING unless referenced in a route table
############################################
resource "aws_internet_gateway" "terraform_ap_northeast_3_igw" {
  # IGW must be attached to a VPC
  vpc_id = aws_vpc.terraform_ap_northeast_3_vpc.id

  tags = {
    # Identifies this IGW in the AWS Console
    Name = "terraform-${var.terraform_project}-${var.terraform_default_environment}-igw"
  }
}

############################################
# Public Subnets
# - Internet-facing subnets
# - Instances launched here can receive public IPs
# - Used by ALB and other public resources
############################################
resource "aws_subnet" "terraform_ap_northeast_3_public" {
  # Creates multiple subnets using count
  count                   = length(var.terraform_ap_northeast_3_public_subnet_cidrs)

  # Subnet belongs to the VPC
  vpc_id                  = aws_vpc.terraform_ap_northeast_3_vpc.id

  # Each subnet gets its own CIDR block
  cidr_block              = var.terraform_ap_northeast_3_public_subnet_cidrs[count.index]

  # Spread subnets across availability zones
  availability_zone       = var.terraform_ap_northeast_3_public_subnet_azs[count.index]

  # Automatically assign public IPs to instances
  map_public_ip_on_launch = true

  tags = {
    # Name clearly indicates public subnet and index
    Name = "terraform-${var.terraform_project}-${var.terraform_default_environment}-public-${count.index + 1}"
  }
}

############################################
# Public Route Table
# - Controls outbound routing for public subnets
# - Sends all internet traffic to the IGW
############################################
resource "aws_route_table" "terraform_ap_northeast_3_public_rt" {
  vpc_id = aws_vpc.terraform_ap_northeast_3_vpc.id

  # Default route to the internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_ap_northeast_3_igw.id
  }

  tags = {
    # Identifies this as the public route table
    Name = "terraform-${var.terraform_project}-${var.terraform_default_environment}-public-rt"
  }
}

############################################
# Route Table Associations
# - Links public subnets to the public route table
# - Without this, subnets are NOT actually public
# - AWS does NOT support tags for this resource
############################################
resource "aws_route_table_association" "terraform_ap_northeast_3_public_assoc" {
  count = length(aws_subnet.terraform_ap_northeast_3_public)

  # Attach each subnet to the public route table
  subnet_id      = aws_subnet.terraform_ap_northeast_3_public[count.index].id
  route_table_id = aws_route_table.terraform_ap_northeast_3_public_rt.id
}
