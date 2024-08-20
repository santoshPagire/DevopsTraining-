# Project README: Deploying Lightweight Web Applications on AWS

## Project Steps and Deliverables

### 1. EC2 Instance Setup 
- **Launch EC2 Instances:**
  - Launch four EC2 t2.micro instances using Amazon Linux 2 AMI.
  - Assign tags for identification (e.g., "App1-Instance1,""App2-Instance1,").
  ![alt text](<images/Screenshot from 2024-08-19 21-44-39.png>)
  - SSH into each instance and deploy "App1" on two instances and "App2" on the other two.
  ![alt text](<images/Screenshot from 2024-08-19 22-02-40.png>)
  ![alt text](<images/Screenshot from 2024-08-19 22-11-01.png>)


### 2. Security Group Configuration
- **Create Security Groups:**
  - For EC2 instances: Allow inbound HTTP (port 80) and SSH (port 22) traffic from your IP.
  - For ALB: Allow inbound traffic on port 80.
  - Attach security groups to the EC2 instances and ALB.
  ![alt text](<images/Screenshot from 2024-08-19 21-38-36.png>)

### 3. Application Load Balancer Setup with Path-Based Routing 
- **Create an Application Load Balancer (ALB):**
  - Set up the ALB in the same VPC and subnets as the EC2 instances.
  ![alt text](<images/Screenshot from 2024-08-19 22-53-04.png>)
  - Configure two target groups:
    - Target Group 1: For "App1" instances.
    - Target Group 2: For "App2" instances.
  - Register EC2 instances with the appropriate target groups.
  ![alt text](<images/Screenshot from 2024-08-19 22-38-04.png>)


### 4. Testing and Validation 
- **Test Path-Based Routing:**
  - Access the ALB’s DNS name to ensure /app1 routes to "App1" instances and /app2 routes to "App2" instances.
  ![alt text](<images/Screenshot from 2024-08-19 22-54-13.png>)
  ![alt text](<images/Screenshot from 2024-08-19 22-30-35.png>)

### 5. Resource Termination 
- **Terminate EC2 Instances:**
  - Stop and terminate all EC2 instances.
  ![alt text](<images/Screenshot from 2024-08-19 22-59-51.png>)

- **Delete Load Balancer and Target Groups:**
  - Remove the ALB and associated target groups.
  ![alt text](<images/Screenshot from 2024-08-19 22-58-42.png>)
  ![alt text](<images/Screenshot from 2024-08-19 23-01-22.png>)

- **Cleanup Security Groups:**
  - Delete the security groups created for this project.
  ![alt text](<images/Screenshot from 2024-08-19 23-02-13.png>)
