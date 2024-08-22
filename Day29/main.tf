provider "aws" {
  region  = var.region
  profile = "default"
}

module "EC2" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  instance_name = var.instance_name
  instance_type = var.instance_type
}

module "my_infrastructure" {
  source        = "./modules/s3"
  region        = var.region
  bucket_name   = var.bucket_name
}


