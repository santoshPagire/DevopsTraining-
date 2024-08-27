# Multi-Tier Web Application Deployment Using Amazon ECS

## Project Objectives

- Set up an ECS Cluster using the Fargate launch type.
- Deploy a web application with multiple containers (frontend and backend).
- Enable direct communication between frontend and backend services.
- Configure networking and security with VPC, subnets, security groups, and IAM roles.
- Implement auto-scaling policies for ECS services.

## Configuration
# Directory structure
```bash
|
|-- modules
|   |-- ecs
|   |   |-- main.tf
|   |   |-- output.tf
|   |   `-- variables.tf
|   |-- iam
|   |   |-- main.tf
|   |   |-- output.tf
|   |   `-- variables.tf
|   |-- rds
|   |   |-- main.tf
|   |   |-- output.tf
|   |   `-- variables.tf
|   |-- sg
|   |   |-- main.tf
|   |   |-- output.tf
|   |   `-- variables.tf
|   `-- vpc
|       |-- main.tf
|       |-- output.tf
|       `-- variables.tf
|-- main.tf
|-- outputs.tf
`-- variables.tf

```

### 1. **VPC and Networking**

- Creates a VPC with public and private subnets.
- Configures an Internet Gateway for public subnet access.
![alt text](<images/Screenshot from 2024-08-27 21-30-38.png>)

### 2. **RDS Instance**

- Launches an RDS MySQL instance in a private subnet.
- Stores database credentials (password) in plaintext within the configuration (consider using AWS Secrets Manager or SSM Parameter Store in production).
![alt text](<images/Screenshot from 2024-08-27 21-55-40.png>)

### 3. **ECS Cluster and Services**

- Creates an ECS Cluster with Fargate launch type.
![alt text](<images/Screenshot from 2024-08-27 21-41-54.png>)
![alt text](<images/Screenshot from 2024-08-27 21-47-51.png>)


### 4. **IAM Roles**

- Defines IAM roles and policies for ECS task execution and task roles.
![alt text](<images/Screenshot from 2024-08-27 21-51-15.png>)

### 5. **Auto-Scaling Policies**

- Configures auto-scaling for frontend and backend services based on CPU and memory usage.
![alt text](<images/Screenshot from 2024-08-27 21-50-39.png>)

## steps

### 1. **Configure AWS CLI**

Ensure that the AWS CLI is installed and configured with appropriate credentials:

```bash
aws configure
```

### 2. **Initialize Terraform**

Initialize the Terraform working directory:

```bash
terraform init
```
![alt text](<images/Screenshot from 2024-08-27 22-49-49.png>)

### 3. **Plan the Deployment**

Generate an execution plan to review changes:

```bash
terraform plan
```
![alt text](<images/Screenshot from 2024-08-27 22-50-21.png>)

### 4. **Apply the Configuration**

Apply the Terraform configuration to deploy the infrastructure:

```bash
terraform apply
```
![alt text](<images/Screenshot from 2024-08-27 21-27-44.png>)
### 5.Cleaning Up

To delete all the resources created by Terraform, run:

```bash
terraform destroy
```
![alt text](<images/Screenshot from 2024-08-27 22-01-15.png>)