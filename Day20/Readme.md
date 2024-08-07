
### Project 01 

#### 1. Inventory Plugins

**Activity**: Configure a dynamic inventory plugin to manage a growing number of web servers dynamically.

**Steps to Accomplish This:**
1. **Choose a Dynamic Inventory Plugin**:
   - Determine the appropriate dynamic inventory plugin based on your environment (e.g., AWS EC2, Azure, GCP, etc.).
   - For AWS EC2, you would use the `aws_ec2` plugin. 


2. **Install Required Python Libraries**:
   - For AWS EC2, install `boto3` and `botocore` if not already installed:
     ```bash
     pip install boto3 botocore
     ```

3. **Configure the Dynamic Inventory Plugin**:
   - Create a configuration file for the dynamic inventory plugin. For AWS EC2, this might be a file named `aws_ec2.yml`.
   - `aws_ec2.yml` configuration:
     ```yaml
      plugin: amazon.aws.aws_ec2
      regions:
        #- ap-south-1
        - us-east-2
      filters:
        instance-state-name:
          - running
        tag:Name: Santosh
      hostnames:
        - dns-name
      compose:
        ansible_host: public_dns_name

     ```

4. **Test the Dynamic Inventory**:
   - Run Ansible with the dynamic inventory to ensure it retrieves and lists EC2 instances:
     ```bash
     ansible-inventory -i aws_ec2.yml --graph
     ```
     ![alt text](<images/Screenshot from 2024-08-07 17-25-26.png>)

#### 2. Performance Tuning

**Steps to Accomplish This:**
1. **Optimize `ansible.cfg` Settings**:
   - Modify settings related to parallel execution, such as `forks`, to increase concurrency:
     ```ini
     [defaults]
     forks = 20
     ```
   - Adjust other performance-related settings, such as `async` and `poll` to optimize task execution.


#### 3. Debugging and Troubleshooting Playbooks

**Steps to Accomplish This:**
1. **Enable Verbose Output**:
   - Use `-v`, `-vv`, or `-vvv` flags when running playbooks to get more detailed output:
   > playbook.yml
     ```yml
         ---
    - name: Test EC2 Inventory
      hosts: all
      tasks:
         - name: Print hostname
            debug:
            msg: "Host {{ inventory_hostname }} with IP {{ ansible_host }}"

     ```
     ```bash
     ansible-playbook playbook.yml -vvv
     ```
     ![alt text](<images/Screenshot from 2024-08-07 23-04-45.png>)
     ![alt text](<images/Screenshot from 2024-08-07 23-05-36.png>)

#### 4. Exploring Advanced Modules

**Steps to Accomplish This:**
1. **Docker Management**:
   - Write a playbook to manage Docker containers using the `docker_container` module.
   - Sample playbook for managing a Docker container:
     ```yaml
       - name: Docker Container Creation
         hosts: localhost
         tasks:
         - name: Create and start Docker container
           community.docker.docker_container:
               name: my_nginx
               image: nginx:latest
               state: started
               ports:
                 - "8084:80"
               volumes:
                 - /my/local/path:/usr/share/nginx/html
     ```
     ![alt text](<images/Screenshot from 2024-08-07 22-38-09.png>)
     ![alt text](<images/Screenshot from 2024-08-07 22-57-38.png>)



2. **AWS EC2 Management**:
   - Write a playbook to manage AWS EC2 instances using the `aws_ec2` module.
   - Sample playbook for creating an security group:
     ```yaml
     - name: create security group
       hosts: localhost
       tasks:
         - name: Create security group
            amazon.aws.ec2_security_group:
               name: "my-security-group"
               description: "Sec group for app"
               rules:                               
                - proto: tcp
                  ports:
                     - 22
                  cidr_ip: 0.0.0.0/0
                  rule_desc: allow all on ssh port
      
     ```
     ![alt text](<images/Screenshot from 2024-08-07 22-47-47.png>)
