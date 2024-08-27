resource "aws_db_subnet_group" "main" {
  name       = var.db_subnet_group_name
  subnet_ids = var.private_subnets

  tags = {
    Name = "RDS Subnet Group"
  }
}

resource "aws_db_instance" "main" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.vpc_security_group_id]
  skip_final_snapshot  = true

  tags = {
    Name = "MyRDSInstance"
  }
}