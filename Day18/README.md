## Project Overview
This project automates the deployment of a three-tier web application consisting of a frontend (Nginx web server), a backend (Node.js application), and a database (MySQL server) using Ansible roles. The solution leverages Ansible Galaxy roles for efficient configuration and deployment.

## Directory Structure
The project is organized in the following directory structure:

```bash
Day18/
├── roles/
│   ├── frontend/               
│   │   ├── tasks/
│   │   ├── templates/
│   │   └── meta/
│   │       └── main.yml
│   ├── backend/                
│   │   ├── tasks/
│   │   ├── templates/
│   │   └── meta/
│   │       └── main.yml
│   └── database/                
│       ├── tasks/
│       ├── templates/
│       └── meta/
│           └── main.yml
├── inventory.ini
│                
├── deploy.yml
├── test.yml
│                                
└── README.md                   
```
![alt text](<image/Screenshot from 2024-08-05 16-37-14.png>)

## Role Selection and Creation
The following roles are used in this project:

- **Nginx Role**: Manages the frontend web server.
> roles/frontend/tasks/main.yml
```yml
---
- name: Install Nginx
  apt:
    name: nginx
    state: present
    update_cache: yes

- name: Start and enable Nginx
  systemd:
    name: nginx
    state: started
    enabled: yes

- name: Copy Nginx configuration
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  notify: Restart Nginx

- name: Ensure Nginx is running
  service:
    name: nginx
    state: started
    enabled: yes

```

> roles/frontend/handlers/main.yml
```yml
- name: Restart Nginx
  systemd:
    name: nginx
    state: restarted
```
> roles/frontend/templates/nginx.conf.j2
```yml
worker_processes auto;
events {
    worker_connections 1024;
}
http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;
    include /etc/nginx/conf.d/*.conf;
}

```
- **Node.js Role**: Manages the backend application.
> roles/backend/tasks/main.yml
```yml
---
  - name: Ensure ca-certificates is installed
    apt:
      name: ca-certificates
      state: present
      update_cache: yes

  - name: Download the NodeSource GPG key
    shell: |
      curl -o /tmp/nodesource.gpg.key https://deb.nodesource.com/gpgkey/nodesource.gpg.key
    args:
      warn: false

  - name: Add the NodeSource GPG key
    apt_key:
      file: "/tmp/nodesource.gpg.key"
      state: present

  - name: Install the Node.js LTS repository
    apt_repository:
      repo: "deb https://deb.nodesource.com/node_{{ NODEJS_VERSION }}.x {{ ansible_distribution_release }} main"
      state: present
      update_cache: yes

  - name: Install Node.js
    apt:
      name: 
        - nodejs
        - npm
      state: present
```
> roles/backend/vars/main.yml
```yml
---
NODEJS_VERSION: "16"
ansible_distribution_release: "focal"
```
- **MySQL Role**: Manages the database server.
> roles/backend/tasks/main.yml
```yml
---

- name: Installing Mysql
  package:
      name: "{{item}}"
      state: present
      update_cache: yes
  loop:
    - mysql-server
    - mysql-client
    - python3-mysqldb
    - libmysqlclient-dev
    
- name: start and enable mysql service
  service:
      name: mysql
      state: started
      enabled: yes

- name: Set root user password
  mysql_user:
    name: root
    password: "{{root_password}}"
    login_unix_socket: /var/run/mysqld/mysqld.sock
    host: localhost
    login_user: root
    login_password: ''
    state: present

- name: Create admin user with remote access
  mysql_user:
    name: "{{admin_user}}"
    password: "{{admin_password}}"
    priv: '*.*:ALL'
    host: '%'
    append_privs: yes
    login_user: root
    login_password: "{{root_password}}"
    state: present

- name: creating database 
  mysql_db:
    name: "{{db_name}}"
    state: present
    login_user: root
    login_password: "{{root_password}}"

- name: Enable remote login to mysql
  lineinfile:
    path: /etc/mysql/mysql.conf.d/mysqld.cnf
    regex: '^bind-address\s*=\s*127.0.0.1'
    line: 'bind-address = 0.0.0.0'
    backup: yes
  notify:
    - Restart mysql

- name: Execute MySQL secure installation
  expect:
    command: mysql_secure_installation
    responses:
      'Enter password for user root:': "{{ root_password }}"
      'Press y\|Y for Yes, any other key for No': 'Y'
      'Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG': "{{ password_validation_policy }}"
      'Change the password for root \? \(\(Press y\|Y for Yes, any other key for No\)': 'n'
      'Remove anonymous users\? \(Press y\|Y for Yes, any other key for No\)': 'Y'
      'Disallow root login remotely\? \(Press y\|Y for Yes, any other key for No\)': 'Y'
      'Remove test database and access to it\? \(Press y\|Y for Yes, any other key for No\)': 'Y'
      'Reload privilege tables now\? \(Press y\|Y for Yes, any other key for No\)': 'Y'
  environment:
    MYSQL_PWD: "{{ root_password }}"

```
> roles/backend/vars/main.yml
```yml
---
root_password: ####
admin_user: user
admin_password: ******
db_name: test
password_validation_policy: 1    
```

## Dependencies Management
Each role has a `meta/main.yml` file that defines its dependencies. This ensures that the database is set up before deploying the backend application. Example structure for a `meta/main.yml` file:

> roles/frontend/meta/main.yml
```yml
dependencies:
  - { role: database }
  - { role: backend }
```
> roles/backend/meta/main.yml
```yml
dependencies:
  - role: database 
```

## Inventory Configuration
An inventory file (`inventory.ini`) is provided to define the groups of hosts for each tier of the application:

```ini
[frontend]
frontend-server ansible_host=**.**.**.** ansible_user=user ansible_ssh_private_key_file=/path/to/key.pem

[backend]
backend-server ansible_host=**.**.**.** ansible_user=user ansible_ssh_private_key_file=/path/to/key.pem

[database]
database-server ansible_host=**.**.**.** ansible_user=user ansible_ssh_private_key_file=/path/to/key.pem

```
![alt text](<image/Screenshot from 2024-08-05 16-55-12.png>)

## Playbook Creation
The main deployment playbook (`deploy.yml`) orchestrates the roles for deploying the application:

```yaml
- hosts: all
  become: true
  roles:
    - frontend
    - backend
    - database
```
### Running the Playbooks
To deploy the application, run:

```bash
ansible-playbook -i inventory.ini deploy.yml
```
![alt text](<image/Screenshot from 2024-08-05 20-13-41.png>)
![alt text](<image/Screenshot from 2024-08-05 20-14-07.png>)
![alt text](<image/Screenshot from 2024-08-05 20-21-18.png>)
![alt text](<image/Screenshot from 2024-08-05 21-42-07.png>)
> test.yml
```yml
---
- name: Test Node.js Installation
  hosts: target 
  become: true
  tasks:
    - name: Check if Node.js is installed
      command: node -v
      register: node_version
      changed_when: false
      failed_when: node_version.rc != 0

    - name: Print Node.js version
      debug:
        msg: "Node.js version installed: {{ node_version.stdout }}"

    - name: Check if npm (Node Package Manager) is installed
      command: npm -v
      register: npm_version
      changed_when: false
      failed_when: npm_version.rc != 0

    - name: Print npm version
      debug:
        msg: "npm version installed: {{ npm_version.stdout }}"

    - name: Verify that the Node.js application is running (if applicable)
      shell: |
        if pgrep -f 'my-node-app'; then
          echo "Node.js application is running."
        else
          echo "Node.js application is NOT running."
          exit 1
        fi
      register: app_status
      changed_when: false
      failed_when: app_status.rc != 0

    - name: Print application status
      debug:
        msg: "{{ app_status.stdout }}"

```
To test the deployment, run:

```bash
ansible-playbook -i inventory.ini test.yml
```
![alt text](<image/Screenshot from 2024-08-05 23-26-51.png>)
