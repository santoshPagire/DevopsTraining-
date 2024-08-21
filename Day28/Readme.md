
### 1. Setup Terraform Configuration

#### Provider Configuration
- **AWS Provider:** Configure the AWS provider to specify the region for deployment.
- **Region Parameterization:** Ensure the region is parameterized using a Terraform variable for flexibility.
> provider.tf
```yml
provider "aws" {
  region = var.region
}
```
#### VPC and Security Groups
- **VPC Creation:** Create a Virtual Private Cloud (VPC) with a public subnet for the EC2 instance.
- **Security Groups:** Define security groups to:
  - Allow HTTP (port 80) and SSH (port 22) access to the EC2 instance.
  - Allow MySQL (port 3306) access to the RDS instance from the EC2 instance.
  ```yml
  resource "aws_security_group" "ec2" {
    vpc_id = aws_vpc.main.id

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  }
         
  ```

#### EC2 Instance
- **Instance Type:** Define an EC2 instance using the `t2.micro` instance type.
- **Configuration:** Configure the instance to allow SSH and HTTP access.
- **Variables:** Use Terraform variables to define instance parameters like AMI ID and instance type.
```yml
resource "aws_instance" "web" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.public_a.id
  #security_group_ids   = [aws_security_group.ec2.id]
  vpc_security_group_ids = [aws_security_group.ec2.id]  
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  key_name = "SPKey"

  tags = {
    Name = "web-instance"
  }
}
```

#### RDS MySQL DB Instance
- **Instance Type:** Create a `t3.micro` MySQL DB instance within the same VPC.
- **Parameters:** Use Terraform variables to define database parameters such as DB name, username, and password.
- **Accessibility:** Ensure the DB instance is publicly accessible and configure security groups to allow access from the EC2 instance.
```yml
resource "aws_db_instance" "mysql" {
  allocated_storage      = 20
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = true
}
```

#### S3 Bucket
- **Bucket Creation:** Create an S3 bucket for storing static files or configurations.
```yml
resource "aws_s3_bucket" "static_files" {
  bucket = var.bucket_name
  acl    = "private"
}
```
- **IAM Role and Policy:** Allow the EC2 instance to access the S3 bucket by assigning the appropriate IAM role and policy.
```yml
resource "aws_iam_role" "instance_role" {
  name = "ec2_instance_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}
```

#### Outputs
- **Terraform Outputs:** Define Terraform outputs to display:
  - The EC2 instance’s public IP address.
  - The RDS instance’s endpoint.
  - The S3 bucket name.
> Output.tf
```yml
output "ec2_instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "s3_bucket_name" {
  value = aws_s3_bucket.static_files.bucket
}
```

### 2. Apply and Manage Infrastructure

#### Initial Deployment
1. **Initialize Configuration:** Run `terraform init` to initialize the Terraform configuration.
![alt text](<images/Screenshot from 2024-08-20 15-40-06.png>)
2. **Review Changes:** Use `terraform plan` to review the infrastructure changes before applying.
![alt text](<images/Screenshot from 2024-08-20 15-45-35.png>)
3. **Deploy Infrastructure:** Deploy the infrastructure using `terraform apply`. Ensure that the application server, database, and S3 bucket are set up correctly.
![alt text](<images/Screenshot from 2024-08-20 16-39-48.png>)

#### Change Sets
1. **Modify Configuration:** Make a minor change in the Terraform configuration, such as modifying an EC2 instance tag or changing an S3 bucket policy.
2. **Generate Change Set:** Use `terraform plan` to generate a change set showing what will be modified.
3. **Apply Changes:** Apply the change set using `terraform apply` and observe how Terraform updates the infrastructure without disrupting existing resources.
![alt text](<images/Screenshot from 2024-08-20 17-04-05.png>)

### 3. Testing and Validation
- **EC2 Instance:** Access the EC2 instance via SSH and HTTP to ensure it's reachable.

- **RDS MySQL DB:** Connect to the MySQL DB instance from the EC2 instance to verify connectivity.
![alt text](<images/Screenshot from 2024-08-20 18-09-00.png>)
- **S3 Bucket Access:** Verify that the EC2 instance can read and write to the S3 bucket.
![alt text](<images/Screenshot from 2024-08-20 18-49-09.png>)
![alt text](<images/Screenshot from 2024-08-20 18-55-57.png>)
- **Check Outputs:** Verify that Terraform outputs correctly display the EC2 instance’s public IP address, RDS instance’s endpoint, and S3 bucket name.
![alt text](<images/Screenshot from 2024-08-20 16-31-44.png>)


### 4. Resource Termination
1. **Destroy Resources:** Once the deployment is complete and validated, run `terraform destroy` to tear down all resources created by Terraform.
![alt text](<images/Screenshot from 2024-08-21 10-01-24.png>)
![alt text](<images/Screenshot from 2024-08-21 10-10-05.png>)