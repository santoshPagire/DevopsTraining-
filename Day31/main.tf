provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "./modules/VPC"

  cidr_block          = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  public_subnet_az    = "us-west-2a"
  private_subnet_cidr = "10.0.2.0/24"
  private_subnet_az   = "us-west-2b"
}

module "ec2" {
  source = "./modules/EC2"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.vpc.security_group_id
}

module "rds" {
  source = "./modules/RDS"

  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  #db_subnet_group_name = module.vpc.public_subnet_id
  subnet_ids             = [module.vpc.public_subnet_id, module.vpc.private_subnet_id]
}

module "s3" {
  source = "./modules/S3"

  bucket_name = var.bucket_name
}

module "iam" {
  source = "./modules/IAM"

  # role_name = "my-iam-role"
}

# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

# output "public_subnet_id" {
#   value = module.vpc.public_subnet_id
# }

# output "private_subnet_id" {
#   value = module.vpc.private_subnet_id
# }

# output "internet_gateway_id" {
#   value = module.vpc.internet_gateway_id
# }

# output "route_table_id" {
#   value = module.vpc.route_table_id
# }

# output "security_group_id" {
#   value = module.vpc.security_group_id
# }

# output "ec2_instance_id" {
#   value = module.ec2.instance_id
# }

# output "rds_instance_id" {
#   value = module.rds.db_instance_id
# }

# output "s3_bucket_id" {
#   value = module.s3.bucket_id
# }

# output "iam_role_arn" {
#   value = module.iam.role_arn
# }
