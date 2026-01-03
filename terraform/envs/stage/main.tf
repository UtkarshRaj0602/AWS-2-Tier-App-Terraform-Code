module "vpc" {
  source = "../../modules/vpc"

  environment          = "stage"
  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_support   = true
  enable_dns_hostnames = true
  region               = "ap-south-1"
  aws_internet_gateway = "igw"

  tags = {
    Project     = "AWS-2-Tier-App"
    Environment = "Stage"
  }
}