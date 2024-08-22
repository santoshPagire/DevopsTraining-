provider "aws" {
  region = "us-east-1"
}

module "ec2_s3" {
  source           = "./modules/aws_infrastructure"
  ami_id           = var.ami_id 
  instance_type    = var.instance_type
  key_name         = var.key_name
  bucket_name      = var.bucket_name
  private_key_path = var.private_key_path
}
