# Project 01

## Part 1: Implementing a Custom IAM Policy for S3 Access

### Scenario

You need to implement a policy to allow a specific IAM role, `DevTeamRole`, to list and read objects in an S3 bucket named `application-logs1`. No other actions should be permitted, and no other users or roles should have access to this bucket.

### Steps

1. **Understand the Requirements**:
   - Review the scenario to ensure that only `DevTeamRole` has access to the `application-logs1` bucket.
   - The policy should permit only `s3:ListBucket` and `s3:GetObject` actions.

2. **Create a New IAM Policy**:
   - Navigate to the IAM console and create a new custom policy.
   - Define the policy with permissions for `s3:ListBucket` and `s3:GetObject`.
   - Specify the ARN of the `application-logs1` bucket and objects within it as resources.

    Policy JSON:
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": [
           "s3:ListBucket"
         ],
         "Resource": "arn:aws:s3:::application-logs1"
       },
       {
         "Effect": "Allow",
         "Action": [
           "s3:GetObject"
         ],
         "Resource": "arn:aws:s3:::application-logs1/*"
       }
     ]
   }

![alt text](<images/Screenshot from 2024-08-12 20-37-30.png>)

3. **Attach the Policy to the IAM Role**:
   - Attach the custom policy to the `DevTeamRole` role.
   - Ensure no other users or roles are granted access to this bucket by this policy.
   ![alt text](<images/Screenshot from 2024-08-12 17-27-07.png>)
   ![alt text](<images/Screenshot from 2024-08-12 17-27-29.png>)

4. **Test the Policy**:
   - Attempt to access the S3 bucket using `DevTeamRole` to ensure only the allowed actions (`ListBucket` and `GetObject`) are permitted.
   ![alt text](<images/Screenshot from 2024-08-12 18-05-30.png>)
   - Document the results, ensuring actions outside the allowed scope (e.g., delete, write) are correctly denied.
   ![alt text](<images/Screenshot from 2024-08-12 17-40-42.png>)

## Part 2: Estimating a Multi-Tier Architecture Solution
### Steps
1. **Define the Architecture**:
   - Identify required components: Application Load Balancer, EC2 instances for the application tier, and an RDS instance for the database.
   - Choose appropriate EC2 instance types and RDS configurations based on expected traffic and load.

2. **Select AWS Services**:
   - Choose an Application Load Balancer for traffic distribution.
   - Select EC2 instance types (e.g., `t3.medium`) for application servers.
   - Choose an RDS instance type (e.g., `db.m5.large`) for the database.

3. **Estimate Costs Using AWS Pricing Calculator**:
   - Navigate to the [AWS Pricing Calculator]
   - Add the Application Load Balancer, EC2 instances, and RDS instance to the estimate.
   - Configure each service based on expected load and specifications (e.g., storage, data transfer).

![alt text](<images/Screenshot from 2024-08-12 20-23-12.png>)
![alt text](<images/Screenshot from 2024-08-12 20-22-55.png>)

