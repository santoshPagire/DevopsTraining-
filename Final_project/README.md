# Modular E-Commerce Application Deployment with S3 Integration

## Project Objectives

1. **Modular Infrastructure:** Use Terraform to create and manage modular infrastructure components.
2. **Static Asset Storage:** Store and fetch static assets from an S3 bucket.
3. **Containerization:** Package the application using Docker.
4. **Orchestration:** Deploy the application on Kubernetes.
5. **CI/CD Pipeline:** Automate the build and deployment process using Jenkins.
6. **Configuration Management:** Use Ansible for configuration management.
7. **Deployment:** Deploy the application using Helm charts.
8. **AWS Resources:** Utilize AWS EC2 free tier instances for deployment.

## Project Tasks and Timeline

### 1. Set Up AWS EC2 Instances 
- Launch three EC2 instances of type `t2.micro` (1 master node, 2 worker nodes) within the free tier.

![alt text](<Images/Screenshot from 2024-09-09 07-29-59.png>)

- Configure security groups to allow necessary ports (e.g., 22 for SSH, 80 for HTTP, 443 for HTTPS).

![alt text](<Images/Screenshot from 2024-09-09 07-30-28.png>)

- SSH into the instances and prepare for Kubernetes installation.
![alt text](<Images/Screenshot from 2024-09-09 07-42-26.png>)
![alt text](<Images/Screenshot from 2024-09-09 07-43-26.png>)
### 2. Create and Configure S3 Bucket 
- Create an S3 bucket to store static assets (e.g., product images, stylesheets).

![alt text](<Images/Screenshot from 2024-09-09 07-33-36.png>)

- Upload sample static files to the S3 bucket.

![alt text](<Images/Screenshot from 2024-09-09 07-37-07.png>)
![alt text](<Images/Screenshot from 2024-09-09 07-37-36.png>)


### 3. Set Up Kubernetes Cluster 
- **On Master Node:**
  - Install Kubeadm, Kubelet, and Kubectl.
  - Initialize the Kubernetes cluster using Kubeadm.
  - Set up a network plugin (e.g., Calico, Flannel).

- **On Worker Nodes:**
  - Join worker nodes to the master node.

![alt text](<Images/Screenshot from 2024-09-09 07-56-04.png>)
### 4. Modularize Infrastructure with Terraform 
- **Create Terraform Modules:**
  - **Network Module:** Define VPC, subnets, and security groups.
  - **Compute Module:** Define EC2 instances for Kubernetes nodes.
  - **Storage Module:** Define S3 bucket for static assets.
- **Main Configuration:**
  - Create a `main.tf` file to utilize the modules and provision the entire infrastructure.
- **Initialize and Apply:**
  - Run `terraform init`, `terraform plan`, and `terraform apply` to provision the infrastructure.

![alt text](<Images/Screenshot from 2024-09-09 07-17-41.png>)
![alt text](<Images/Screenshot from 2024-09-09 07-29-26.png>)
### 5. Containerize the Application with Docker 
- **Dockerfile:** Write Dockerfile for the e-commerce application.

[Dockerfile](frontend/Dockerfile)
```yml
# Use the official Nginx image from Docker Hub
FROM nginx:latest

# Copy custom Nginx configuration file into the container
# If you have custom configurations, you can include them
COPY nginx.conf /etc/nginx/nginx.conf

# Copy your web content into the container
# This example assumes you have a directory named `public-html` with your web content
COPY /css /usr/share/nginx/html/css
COPY /img /usr/share/nginx/html/img
COPY /js /usr/share/nginx/html/js
COPY /lib /usr/share/nginx/html/lib
COPY /scss /usr/share/nginx/html/scss
COPY  /*.html /usr/share/nginx/html/
COPY  /*.jpg /usr/share/nginx/html/
COPY  /*.txt /usr/share/nginx/html/
# Expose port 80 to the outside world
EXPOSE 80
```
- **Build Docker Image:** Build Docker images using the Dockerfile.
![alt text](Images/jenkin4.png)
- **Push to Registry:** Push Docker images to a Docker registry (e.g., Docker Hub, Amazon ECR).

![alt text](Images/jenkin5.png)

### 6. Configure Ansible for Application Deployment 
- **Ansible Playbooks:** Write playbooks to configure Kubernetes nodes and deploy the application.
- **Test Playbooks:** Run Ansible playbooks to ensure correct configuration.


### 7. Set Up Jenkins for CI/CD 

- **Configure Jenkins Pipeline:**
  - Create a Groovy pipeline script in Jenkins for CI/CD.
  
  [Jenkinsfile](Jenkinsfile)
  
  - The pipeline should include stages for:
    - **Source Code Checkout:** Pull code from the Git repository.
    - **Build Docker Image:** Build Docker images from the Dockerfile.
    - **Push Docker Image:** Push Docker image to Docker registry.
    ![alt text](<Images/jenkin1.png>)
    ![alt text](<Images/jenkin2.png>)
    ![alt text](<Images/jenkin3.png>)

### 8. Deploy the Application with Helm 
- **Create Helm Charts:** Define Helm charts for the e-commerce application deployment.
![alt text](<Images/Screenshot from 2024-09-09 07-57-55.png>)
- **Install Helm Charts:** Deploy the application to Kubernetes using Helm charts.
![alt text](<Images/Screenshot from 2024-09-09 08-01-14.png>)
![alt text](<Images/Screenshot from 2024-09-09 08-10-01.png>)
- **Verify Deployment**
![alt text](<Images/Screenshot from 2024-09-09 08-14-43.png>)
- Check on which dataplane application is deployed
![alt text](<Images/Screenshot from 2024-09-09 08-15-07.png>)
![alt text](<Images/Screenshot from 2024-09-09 08-15-29.png>)
- **Check Output:**
![alt text](<Images/Screenshot from 2024-09-09 08-15-45.png>)
### 9. Clean Up Resources 
- **Terminate Resources:** Use Terraform to destroy all provisioned infrastructure by running `terraform destroy`.
![alt text](<Images/Screenshot from 2024-09-09 08-21-31.png>)
![alt text](<Images/Screenshot from 2024-09-09 08-21-53.png>)


