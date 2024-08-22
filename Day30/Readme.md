# Advanced Terraform with Provisioners, Modules, and Workspaces

## Project Objective

This project aims to evaluate your understanding of advanced Terraform concepts including provisioners, modules, and workspaces. You will deploy a basic infrastructure on AWS using Terraform, execute remote commands on the provisioned resources, and manage multiple environments. All resources should be within AWS Free Tier limits.

## Key Tasks

### Module Development

1. **Module Setup**: 
   - Create a directory for the module, e.g., `modules/aws_infrastructure`.
```bash
   mkdir modules/aws_infrastructure
```
2. **Resource Definitions**: 
   - Define an EC2 instance and an S3 bucket within the module.
```hcl
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
      user        = "ubuntu"  # Adjust the user as per the AMI
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


```
3. **Variable Inputs**: 
   - Define variables for instance type, AMI ID, key pair name, and S3 bucket name.
```hcl
variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The key pair name for the EC2 instance"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private key file for SSH access"
  type        = string
}

```
4. **Outputs**: 
   - Define outputs for the EC2 instance’s public IP and the S3 bucket’s ARN.
```hcl
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "bucket_arn" {
  value = aws_s3_bucket.new.arn
}

```

### Main Terraform Configuration

1. **Main Config Setup**: 
   - In the root directory, create a Terraform configuration to call the custom module.
```hcl
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

```

### Provisioner Implementation

1. **Remote Execution**: 
   - Use `remote-exec` to SSH into the EC2 instance and execute a script to install Apache.
```hcl
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
```
2. **Local Execution**: 
   - Use `local-exec` to print a confirmation message on the local machine after successful deployment.
```hcl
  provisioner "local-exec" {
    command = "echo 'EC2 instance successfully provisioned with Apache.'"
  }
```

### Workspace Management

1. **Workspace Creation**: 
   - Create workspaces for dev and prod.
```bash
terraform workspace new dev
terraform workspace new prod
```
   - List Workspaces
```bash
terraform workspace list
```
![alt text](<images/Screenshot from 2024-08-22 17-44-48.png>)
   - Switch to workspaces
```bash
terraform workspace select dev
terraform workspace select prod
```
2. **Environment-Specific Configurations**: 
   - Customize EC2 instance tags and S3 bucket names for each workspace.
![alt text](<images/Screenshot from 2024-08-22 17-55-21.png>)
![alt text](<images/Screenshot from 2024-08-22 17-55-32.png>)
![alt text](<images/Screenshot from 2024-08-22 22-43-38.png>)

![alt text](<images/Screenshot from 2024-08-22 21-51-06.png>)
![alt text](<images/Screenshot from 2024-08-22 21-51-31.png>)
3. **Workspace Deployment**: 
   - Deploy infrastructure separately in dev and prod workspaces.
![alt text](<images/Screenshot from 2024-08-22 21-46-26.png>)
![alt text](<images/Screenshot from 2024-08-22 22-42-04.png>)

### Validation and Testing

1. **Apache Installation Verification**: 
   - Verify Apache installation by accessing the EC2 instance’s public IP in a web browser.
![alt text](<images/Screenshot from 2024-08-22 17-13-38.png>)
2. **Workspace Separation**: 
Confirm isolated infrastructure and state files for each workspace.
![alt text](<images/Screenshot from 2024-08-22 22-08-09.png>)

### Resource Cleanup

1. **Destroy Resources**: 
   - Use `terraform destroy` to remove resources in both workspaces.
![alt text](<images/Screenshot from 2024-08-22 21-55-03.png>)
![alt text](<images/Screenshot from 2024-08-22 22-19-36.png>)