provider "aws" {
  region = "us-east-1" 
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name       = var.key_name

  tags = {
    Name = "${terraform.workspace}-webserver"
  }

  provisioner "remote-exec" {
    inline = [
    "sudo apt-get update -y",
    "sudo apt-get install -y apache2",
    "sudo systemctl start apache2",
    "sudo systemctl enable apache2"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"  
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "echo 'EC2 instance successfully provisioned with Apache.'"
  }
}


resource "aws_s3_bucket" "new" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name = "new-test-bucket-s1241-${terraform.workspace}"
  }
}

