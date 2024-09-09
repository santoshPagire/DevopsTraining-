resource "aws_instance" "master" {
  ami                    = var.ami
  instance_type          = var.instance_type_1
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile   = var.iam_instance_profile

  tags = merge({
    Name = var.instance_name_1
  })
}

resource "aws_instance" "worker_1" {
  ami                    = var.ami
  instance_type          = var.instance_type_2
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile   = var.iam_instance_profile

  tags = merge({
    Name = var.instance_name_2
  })
}

resource "aws_instance" "worker_2" {
  ami                    = var.ami
  instance_type          = var.instance_type_2
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile   = var.iam_instance_profile

  tags = merge({
    Name = var.instance_name_3
  })
}
