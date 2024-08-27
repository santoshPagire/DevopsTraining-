provider "aws" {
  region  = "us-east-2"
  version = "~> 5.0"
}

module "vpc" {
  source = "./modules/vpc"

  cidr             = var.cidr
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  availability_zones = var.availability_zones
}

module "security_groups" {
  source            = "./modules/sg"
  vpc_id            = module.vpc.vpc_id
  container_port    = var.container_port
  name              = var.name
  environment       = var.environment
}

module "ecs" {
  source               = "./modules/ecs"
  cluster_name         = var.cluster_name
  task_family_name     = var.task_family_name
  container_image      = var.container_image
  container_port       = var.container_port
  container_environment = var.container_environment
  ecs_service_name     = var.ecs_service_name
  alb_security_group_id = module.security_groups.alb_security_group_id
  vpc_id               = module.vpc.vpc_id
  public_subnets       = module.vpc.public_subnets
}

module "rds" {
  source                = "./modules/rds"
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  vpc_security_group_id = module.security_groups.rds_security_group_id
  private_subnets       = module.vpc.private_subnets
}

module "iam" {
  source                = "./modules/iam"
}