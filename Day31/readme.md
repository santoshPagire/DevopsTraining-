## Project Overview

This project involves deploying a basic 3-tier web application architecture using Terraform. The architecture includes the following components:

1. **VPC**: Virtual Private Cloud (VPC) with public and private subnets across two availability zones.
2. **Security Groups**: Security groups to manage inbound and outbound traffic for the application and database tiers.
3. **EC2 Instances**: EC2 instances in public subnets for the web servers (Application Tier).
4. **RDS Instance**: RDS MySQL instance in the private subnet for the database (Database Tier).
5. **S3 Bucket**: S3 bucket for storing static files with versioning enabled.
6. **Elastic IPs**: Elastic IPs assigned to the EC2 instances.
7. **IAM Role**: IAM role with necessary permissions attached to the EC2 instances.

## Project Steps

### Step 1: Setup Remote State and Locking

1. Create an S3 bucket for storing Terraform state.
![alt text](<images/Screenshot from 2024-08-24 00-09-48.png>)
2. Create a DynamoDB table for state locking.
![alt text](<images/Screenshot from 2024-08-24 00-09-48.png>)
3. Configure the backend in Terraform to use the S3 bucket and DynamoDB table.
>backend.tf
```hcl
terraform {
  backend "s3" {
    bucket         = var.pre_bucket_name
    key            = "terraform/state.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = var.table_name
  }
}

```

### Step 2: Develop and Organize Modules

1. Develop modules for VPC, EC2, RDS, S3, and IAM.
2. Place each module in a separate directory with `main.tf`, `variables.tf`, and `outputs.tf`.
![alt text](<images/Screenshot from 2024-08-24 00-35-28.png>)

### Step 3: Define Variables and `.tfvars` Files

1. Define variables in `variables.tf` files within each module.
2. Create a `terraform.tfvars` file with default values.
![alt text](<images/Screenshot from 2024-08-24 00-41-36.png>)

### Step 4: Implement Workspaces

1. Initialize Terraform and create workspaces (development, staging, production).
![alt text](<images/Screenshot from 2024-08-24 00-31-15.png>)
2. Deploy infrastructure in each workspace using the appropriate `.tfvars` file.
![alt text](<images/Screenshot from 2024-08-24 00-27-16.png>)
![alt text](<images/Screenshot from 2024-08-24 00-28-22.png>)


### Step 5: Deploy the Infrastructure

1. Use the `terraform apply` command to deploy the infrastructure in each workspace.
![alt text](<images/Screenshot from 2024-08-23 23-33-30.png>)
2. Verify the deployment by accessing EC2 instances and ensuring the application is running.
![alt text](<images/Screenshot from 2024-08-23 22-28-27.png>)

### Step 6: Implement Lifecycle Rules

1. Modify Terraform code to add lifecycle rules for critical resources.
![alt text](<images/Screenshot from 2024-08-24 00-52-35.png>)

### Step 7: Cleanup

1. Destroy the infrastructure in each workspace using `terraform destroy`.
![alt text](<images/Screenshot from 2024-08-23 23-15-37.png>)

### Resources
1. Instance
![alt text](<images/Screenshot from 2024-08-23 22-28-27.png>)
2. VPC
![alt text](<images/Screenshot from 2024-08-23 22-30-07.png>)
3. IAM Role
![alt text](<images/Screenshot from 2024-08-23 22-33-13.png>)
4. Subnets 
![alt text](<images/Screenshot from 2024-08-23 22-34-20.png>)
5. Route Tables
![alt text](<images/Screenshot from 2024-08-23 23-42-39.png>)
6. Internet gateway
![alt text](<images/Screenshot from 2024-08-23 23-43-30.png>)
7. Security group
![alt text](<images/Screenshot from 2024-08-23 23-40-45.png>)
8. RDS
![alt text](<images/Screenshot from 2024-08-23 23-38-24.png>)
9. S3 bucket
![alt text](<images/Screenshot from 2024-08-23 23-39-20.png>)