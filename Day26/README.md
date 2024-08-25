Assessment Project: End-to-End Deployment and Management of a Scalable E-Commerce Platform on AWS
======

**Objective:**

To evaluate your proficiency in designing, deploying, and managing a comprehensive and scalable e-commerce platform on AWS. The project will integrate multiple AWS services, including S3, EC2, Auto Scaling, Load Balancer, VPC (without NAT Gateway), and RDS. The platform must be highly available, secure, and optimized for performance.

## Project Steps and Deliverables:
### 1. VPC Design and Implementation :

- **Design a Custom VPC:**
    - Create a VPC with four subnets: two public subnets (for EC2 instances and Load Balancers) and two private subnets (for RDS and backend services).

<!-- vpc create -->
![alt text](<images/Screenshot from 2024-08-24 19-09-36.png>)

<!-- subnet create -->
<!-- route table create -->

- Set up an Internet Gateway to allow internet access for the public subnets.
- Configure routing tables to enable communication between the subnets, ensuring that the private subnets can only communicate with the public subnets.
![alt text](<images/Screenshot from 2024-08-24 19-09-22.png>)

- **Security Configuration:**
    - Create security groups to control inbound and outbound traffic for EC2 instances, Load Balancer, and RDS.
    - Implement network ACLs to add an additional layer of security at the subnet level.
![alt text](<images/Screenshot from 2024-08-24 19-20-47.png>)

### 2. S3 Bucket Configuration for Static Content :

- **Create and Configure S3 Buckets:**
    - Create an S3 bucket named shopmax-static-content-chirag for hosting static assets (e.g., images, CSS, JavaScript).

<!-- S3 bucket with css and js files -->
![alt text](<images/Screenshot from 2024-08-24 21-46-12.png>)

- Set appropriate bucket policies to allow public read access to the static content.
![alt text](<images/Screenshot from 2024-08-24 19-36-14.png>)

<!-- bucket policy -->
![alt text](<images/Screenshot from 2024-08-24 21-48-38.png>)


- Enable versioning and logging on the bucket for better management and auditability.

![alt text](<images/Screenshot from 2024-08-24 19-36-58.png>)

### 3. EC2 Instance Setup and Web Server Configuration :

- **Launch EC2 Instances:**
    - Launch a pair of EC2 instances (t2.micro ONLY) in the public subnets using an Amazon Linux 2 AMI.

<!-- Webserver Ec2 Instance -->
![alt text](<images/Screenshot from 2024-08-24 21-59-12.png>)
<!-- Application Server Ec2 Instance -->

- SSH into the instances and install a web server (Apache or Nginx) along with necessary application dependencies.

- **Deploy the Application:**
    - Deploy the  application on instances.
![alt text](<images/Screenshot from 2024-08-24 23-26-41.png>)

<!-- Installing Website and configuring it -->
![alt text](img/image11.png)

- Configure the web server to serve dynamic content and integrate with the static content hosted on S3.

```bash

sudo mkdir -p /var/www/html/web
sudo cp *html /var/www/html/web/
cd /var/www/html/web

# change the configuration file of apache2 by using below steps
cd /etc/apache2/sites-available
sudo cp 000-default.conf web.conf
```
> web.conf file
```xml
<VirtualHost *:80>
    ServerAdmin webmaster@localhost

    DocumentRoot /var/www/html/web

    ErrorLog ${APACHE_LOG_DIR}/web_error.log
    CustomLog ${APACHE_LOG_DIR}/web_access.log combined

    <Directory /var/www/html/web>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```
```bash
# after changing the config file of apache 2 use below commands
sudo a2dissite 000-default.conf
sudo a2ensite web.conf
sudo systemctl daemon-reload
sudo systemctl enable apache2
sudo systemctl restart apache2
```

<span style="color:">
Change the paths of the css, js files and paths of all the images in all of the .html files with the path of objects in the s3 bucket <b>shopmax-static-content-sp<b>
</span>

### 4. RDS Setup and Database Configuration :

- **Provision an RDS MySQL Instance:**
    - Launch an RDS instance (Free Tier Template Type, t3.micro ONLY) in the private subnets, ensuring that it is not publicly accessible.

    ![alt text](<images/Screenshot from 2024-08-24 22-23-39.png>)
    
    - Configure the database schema to support the e-commerce application (e.g., tables for users, orders, products).
    - Set up automated backups to ensure high availability.
    ![alt text](<images/Screenshot from 2024-08-24 22-42-10.png>)

- **Database Security:**

    - Implement security measures such as encryption at rest and in transit.
    - Restrict database access to only the EC2 instances in the public subnets via security groups.

    ![alt text](<images/Screenshot from 2024-08-24 22-24-00.png>)

### 5. Load Balancer and Auto Scaling Configuration :

- **Set Up an Application Load Balancer (ALB):**
    - Deploy an ALB in the public subnets to distribute traffic across the EC2 instances.
    - Create a target group and register the EC2 instances, ensuring health checks are configured properly.
![alt text](<images/Screenshot from 2024-08-24 22-50-17.png>)
![alt text](<images/Screenshot from 2024-08-24 22-48-28.png>)


- **Configure Auto Scaling:**

    - Before creating Auto Scaling group create launch template of Amazon Linux 2 AMI with t2 micro instance type

![alt text](<images/Screenshot from 2024-08-24 22-59-15.png>)

- Create an Auto Scaling group that launches additional EC2 instances based on traffic patterns (e.g., CPU utilization). (Desired: 2, minimum:1 and maximum: 2 instances)

![alt text](<images/Screenshot from 2024-08-24 23-12-24.png>)

- Define scaling policies to automatically add or remove instances based on demand.

![alt text](<images/Screenshot from 2024-08-24 23-16-15.png>)

- **Testing the Setup:**
    - Simulate traffic to test the scalability and fault tolerance of the infrastructure.
    - Verify that the ALB is evenly distributing traffic and that the Auto Scaling group is working as expected.

![alt text](<images/Screenshot from 2024-08-24 23-14-54.png>)
![alt text](<images/Screenshot from 2024-08-24 23-14-23.png>)

### 6. Testing, Validation, and Optimization :

- **Full Application Test:**
    - Access the e-commerce application via the ALB DNS name and ensure that both static and dynamic content is being served correctly.

<!-- for /app1/ -->
![alt text](<images/Screenshot from 2024-08-24 22-52-56.png>)

- **Cleanup:**
    - Terminate all the resources created i.e VPC, EC2 instances, Templates, target group, security group, private key-pair, RDS instances, Auto scaling group, Application Load Balancer

1. EC2 instances:<br>
![alt text](<images/Screenshot from 2024-08-24 23-18-06.png>)

2. Auto Scaling group:<br>
![alt text](<images/Screenshot from 2024-08-24 23-17-02.png>)

3. Application Load Balancer:<br>
![alt text](<images/Screenshot from 2024-08-24 23-21-01.png>)

4. Target Groups:<br>
![alt text](<images/Screenshot from 2024-08-24 23-20-26.png>)

5. Instance Templates:<br>
![alt text](<images/Screenshot from 2024-08-24 23-17-26.png>)

6. RDS Database:<br>
![alt text](<images/Screenshot from 2024-08-24 23-19-16.png>)

7. S3 bucket:<br>
![alt text](<images/Screenshot from 2024-08-24 23-25-41.png>)

8. VPC, Route Tables, Subnets, Internet Gateway and Security Groups:<br>
![alt text](<images/Screenshot from 2024-08-24 23-22-01.png>)

