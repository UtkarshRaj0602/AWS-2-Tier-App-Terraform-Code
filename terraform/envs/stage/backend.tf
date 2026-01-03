terraform {
  backend "s3" {
    bucket = "practice-terraform-states-bucket"
    key    = "stage/terraform.tfstate"
    region = "ap-south-1"
  }
}