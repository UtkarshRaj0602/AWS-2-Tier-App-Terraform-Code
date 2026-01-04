module "vpc" {
  source = "../../modules/vpc"

  environment          = "stage"
  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_support   = true
  enable_dns_hostnames = true
  aws_internet_gateway = "igw"

  tags = {
    Project     = "AWS-2-Tier-App"
    Environment = "Stage"
  }
}

module "ec2" {
  source = "../../modules/ec2"

  environment    = "stage"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.private_subnet_ids[0]
  ami_id         = "ami-00ca570c1b6d79f36"
  instance_type  = "t3a.micro"
  instance_count = 1

  user_data = file("${path.module}/user_data.sh")

  iam_instance_profile = "EC2-SSM-Role"
  allowed_ingress_cidr = [module.vpc.vpc_cidr]
  http_ingress_cidrs   = ["0.0.0.0/0"]
  https_ingress_cidrs  = ["0.0.0.0/0"]
  keypair_bucket_name  = "practice-terraform-states-bucket"

  root_volume_size      = 30
  root_volume_type      = "gp3"
  root_volume_encrypted = false

  tags = {
    Project     = "AWS-2-Tier-App"
    Environment = "Stage"
  }
}

