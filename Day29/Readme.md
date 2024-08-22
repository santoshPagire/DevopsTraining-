# Project: Advanced Terraform with Modules, Functions, State Locks, Remote State Management, and Variable Configuration

### 1. Remote State Management

#### **S3 Bucket for State**
1. **Create an S3 Bucket for Terraform State**:
   Create a new Terraform configuration file to set up the S3 bucket. This bucket will be used to store the Terraform state file.

```hcl
provider "aws" {
  region  = var.region
  profile = "default"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket
  # acl    = "private"

  tags = {
    Name = "Terraform_State_Bucket"
  }
}

```
![alt text](<image/Screenshot from 2024-08-21 17-43-41.png>)
![alt text](<image/Screenshot from 2024-08-21 17-57-34.png>)
![alt text](<image/Screenshot from 2024-08-21 17-58-11.png>)
![alt text](<image/Screenshot from 2024-08-21 22-31-09.png>)
![alt text](<image/Screenshot from 2024-08-21 22-46-09.png>)

2. **Configure Terraform to Use the S3 Bucket for State**:
   In your Terraform configuration, configure the backend to use the S3 bucket for state storage.

```hcl
# backend.tf
terraform {
  backend "s3" {
    bucket         = var.pre_bucket_name
    key            = "terraform/state.tfstate"
    region         = var.region
    encrypt        = true
    dynamodb_table = var.table_name
  }
}
```

   Initialize Terraform to configure the backend:

```sh
   terraform init
```
![alt text](<image/Screenshot from 2024-08-21 17-59-43.png>)


#### **State Locking with DynamoDB**
1. **Create a DynamoDB Table for State Locking**:
   Create a DynamoDB table to handle state locking. This can be included in the same Terraform configuration or created separately.

```hcl
   # dynamodb.tf
resource "aws_dynamodb_table" "terraform_temp_locks" {
  name         = var.name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform State Lock Table"
  }
}
```
![alt text](<image/Screenshot from 2024-08-21 22-28-18.png>)

2. **Configure Terraform to Use DynamoDB for State Locking**:
   Update the backend configuration to include DynamoDB for state locking.

```hcl
   # backend.tf 
terraform {
  backend "s3" {
    bucket         = var.pre_bucket_name
    key            = "terraform/state.tfstate"
    region         = var.region
    encrypt        = true
    dynamodb_table = var.table_name
  }
}

```

   Reinitialize Terraform to apply the updated backend configuration:

   ```sh
   terraform init
   ```

### 2. Terraform Module Creation

#### **Custom Module**
1. **Create a Directory for the Module**:
   Create a new directory for your Terraform module.

```sh
   mkdir -p modules/ec2
```

2. **Define the Module**:
   Inside `modules/ec2`, create `main.tf` to define the EC2 instance and S3 bucket resources.

```hcl
   # modules/ec2/main.tf
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
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = join("-", [var.instance_name, "server"])
  }
}
```
![alt text](<image/Screenshot from 2024-08-21 22-29-53.png>)

3. **Output the Information**:
   Define outputs to provide useful information after deployment.

```hcl
   # modules/ec2/outputs.tf
   output "instance_id" {
  value = aws_instance.app_server.id
}

```
![alt text](<image/Screenshot from 2024-08-21 22-46-40.png>)

#### **Root Module**
1. **Use the Module**:
   In your root Terraform configuration, use the module and provide necessary variables.

```hcl
   # main.tf
   provider "aws" {
  region  = var.region
  profile = "default"
}

module "EC2" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  instance_name = var.instance_name
  instance_type = var.instance_type
}

module "my_infrastructure" {
  source        = "./modules/s3"
  region        = var.region
  bucket_name   = var.bucket_name
}
```
 > output.tf
 ```hcl
 output "instance_id" {
  value = module.my_infrastructure.instance_id
}

output "bucket_name" {
  value = module.my_infrastructure.bucket_name
}
 ```

### 3. Terraform Functions
1. **Use Functions in Your Module**:
   Implement functions such as `join`, `lookup`, and `length` in your module as needed. For example, using `join` to create a unique name.

```hcl
   # modules/aws_resources/main.tf (updated)
   resource "aws_s3_bucket" "app_bucket" {
     bucket = join("-", ["app-bucket", substr(md5(var.bucket_name), 0, 6)])
     acl    = "private"
   }
```

### 4. Testing State Locking and Remote State

#### **State Locking**
1. **Test State Locking**:
   Open two terminal sessions and try running `terraform apply` simultaneously in each. Confirm that only one can proceed and that the other is locked.

```sh
   terraform apply
```

   Check the DynamoDB table to verify that the state lock entry is created.

#### **Remote State Management**
1. **Verify Remote State**:
   After deployment, inspect the S3 bucket to ensure that the state file is present. Make changes to the infrastructure and verify that the state file updates accordingly.

### 5. Apply and Modify Infrastructure

#### **Initial Deployment**
1. **Deploy Infrastructure**:
   Run `terraform plan` to review the proposed changes and `terraform apply` to deploy.

```sh
   terraform plan
   terraform apply
```

   Confirm that the EC2 instance, S3 bucket, and all configurations are properly set up.

#### **Infrastructure Changes**
1. **Modify Variables**:
   Change one of the variables (e.g., instance type) in `terraform.tfvars`, then re-run `terraform apply`.

```hcl
   # terraform.tfvars
   instance_type = "t3.micro"
```

   Observe the changes and verify that only the necessary updates are applied.

#### **Resource Termination**
1. **Destroy Resources**:
   Run `terraform destroy` to remove all resources.

```sh
   terraform destroy
```

![alt text](<image/Screenshot from 2024-08-21 22-49-11.png>)
![alt text](<image/Screenshot from 2024-08-21 23-20-44.png>)
![alt text](<image/Screenshot from 2024-08-21 22-50-49.png>)