# S3 Bucket Configuration and Management Project

## Project Overview

This project involves creating and configuring an Amazon S3 bucket to host a static website, implementing storage classes and lifecycle management, configuring bucket policies and ACLs, and validating the configuration. The goal is to ensure the static website is properly hosted, efficiently managed, and securely accessible.

## Project Steps and Deliverables

### 1. Create and Configure an S3 Bucket

1. **Create an S3 Bucket**
   - Bucket Name: `techvista-portfolio-santosh`
   - Steps:
     1. Log in to the AWS Management Console.
     2. Navigate to the S3 service.
     3. Click “Create bucket.”
     4. Enter the bucket name and choose a region.
     5. Click “Create bucket.”
![alt text](<images/Screenshot from 2024-08-13 15-24-42.png>)

2. **Enable Versioning**
   - Navigate to the bucket properties.
   - Enable versioning to keep track of object versions.
![alt text](<images/Screenshot from 2024-08-13 16-22-41.png>)

3. **Set Up Static Website Hosting**
   - In the bucket properties, enable static website hosting.
   - Specify `index.html` as the index document.
![alt text](<images/Screenshot from 2024-08-13 15-39-28.png>)
4. **Upload Static Website Files**
   - Upload HTML, CSS, and image files to the bucket.
![alt text](<images/Screenshot from 2024-08-13 15-44-10.png>)
5. **Ensure Website Accessibility**
   - Verify the website is accessible using the S3 static website URL.
![alt text](<images/Screenshot from 2024-08-13 15-38-22.png>)
### 2. Implement S3 Storage Classes

1. **Classify Content**
   - **HTML/CSS Files**: Use `STANDARD` storage class.
   - **Images**: Use `STANDARD`, `INTELLIGENT-TIERING`, or `GLACIER` based on access frequency.
  
2. **Change Storage Class**
   - Navigate to the “Objects” tab.
   - Select files and change their storage class as needed.
![alt text](<images/Screenshot from 2024-08-13 16-27-10.png>)
### 3. Lifecycle Management

1. **Create Lifecycle Policy**
   - Transition older versions of objects to `GLACIER` after a specified period.
   - Set up a policy to delete non-current versions after 60 days.
![alt text](<images/Screenshot from 2024-08-13 16-29-10.png>)

### 4. Configure Bucket Policies and ACLs

1. **Create Bucket Policy**
   - Allow public read access for static website content.
   - Example policy:
     ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Principal": "*",
           "Action": "s3:GetObject",
           "Resource": "arn:aws:s3:::techvista-portfolio-santosh/*"
         }
       ]
     }
     ```
![alt text](<images/Screenshot from 2024-08-13 15-39-00.png>)

2. **Set Up ACL**
   - Configure ACLs to provide access to a specific folder for an external user.
![alt text](<images/Screenshot from 2024-08-13 16-06-48.png>)

### 5. Test and Validate the Configuration

1. **Test Static Website URL**
   - Ensure the website is accessible via the S3 endpoint.
![alt text](<images/Screenshot from 2024-08-13 15-38-22.png>)
2. **Validate Storage Class Transitions**
   - Confirm objects transition between storage classes based on lifecycle policies.
![alt text](<images/Screenshot from 2024-08-13 16-38-34.png>)

---

