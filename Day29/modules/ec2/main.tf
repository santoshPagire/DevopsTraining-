# here we are using default vpc

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh1"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name       = "SPkey"
  # vpc_security_group_ids = [aws_security_group.allow_ssh.id]  
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = join("-", [var.instance_name, "server"])
  }
}