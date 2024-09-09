provider "aws" {
  region  = "us-east-2"
  version = "~> 5.0"
}


module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
  source            = "./modules/sg"
  name                = "sp-new_sg"
  vpc_id              = module.vpc.vpc_id
  container_port = var.container_port
  environment = var.environment
}

module "iam" {
  source                = "./modules/iam"
}

module "s3_bucket" {
  source          = "./modules/s3"
  }

module "ec2" {
  source              = "./modules/ec2"
  key_name            = "Mynewkey"
  subnet_id           = module.vpc.public_subnet_ids[0]
  security_group_ids  = [module.sg.security_group_id]

  ami                 = var.ami
  instance_type_1     = var.instance_type_1
  instance_type_2     = var.instance_type_2
  instance_name_1     = var.instance_name_1
  instance_name_2     = var.instance_name_2
  instance_name_3     = var.instance_name_3

  iam_instance_profile = module.iam.iam_instance_profile_name

}