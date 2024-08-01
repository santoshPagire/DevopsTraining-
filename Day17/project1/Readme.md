## Problem Statement
Objective: Automate the deployment, configuration, and backup of a PostgreSQL database server on an Ubuntu instance using Ansible.
## Configuration Management:
 Use Ansible to handle the deployment and configuration, including managing sensitive data like database passwords.
### Deliverables
### 1.Ansible Inventory File
Content: Defines the AWS Ubuntu instance and connection details for Ansible.
Filename: inventory.ini
```yml
[web]
target01 ansible_host=000.00.00.000 ansible_user=user ansible_ssh_private_key_file=/path/to/key.pem
```
![alt text](<image/Screenshot from 2024-07-31 16-11-05.png>)
### 2.Ansible Playbook

Content: Automates the installation of PostgreSQL, sets up the database, creates a user, and configures a cron job for backups. It also includes variables for database configuration and backup settings.
> Filename: mysql.yml
```yml
- name: setup Mysql with database db and remote login
  become: yes
  hosts: target

  vars_files: 
    - vars.yml

  tasks:
    - name: Installing Mysql  and dependencies
      package:
       name: "{{item}}"
       state: present
       update_cache: yes
      loop:
       - mysql-server
       - mysql-client 
       - python3-mysqldb
       - libmysqlclient-dev
      become: yes

    - name: start and enable mysql service
      service:
        name: mysql
        state: started
        enabled: yes

    - name: creating mysql user
      mysql_user:
        name: "{{db_user}}"
        password: "{{db_pass}}"
        priv: '*.*:ALL'
        host: '%'
        state: present

    - name: creating database
      mysql_db:
        name: "{{db_name}}"
        state: present

    - name: Enable remote login to mysql
      lineinfile:
         path: /etc/mysql/mysql.conf.d/mysqld.cnf
         regexp: '^bind-address'
         line: 'bind-address = 0.0.0.0'
         backup: yes
      notify:
         - Restart mysql 

    - name: Create Backup Directory
      file: 
        path: /var/backups/mysql
        state: directory

    - name: Create Backup Script
      copy:
        src: scripts/backup.sh
        dest: ~/
        mode: 0755

    - name: Create a cron job for database backup
      cron:
        name: "MySQL Backup"
        minute: "2"
        hour: "0"
        job: "~/backup.sh"  

  handlers:
    - name: Restart mysql
      service:
        name: mysql
        state: restarted
```
### 3.Backup Script
Content: A script to perform the backup of the PostgreSQL database. This script should be referenced in the cron job defined in the playbook.
> Filename: scripts/backup.sh
```bash
#!/bin/bash

# Backup script for MySQL database

DB_NAME="db"
DB_USER="user"
DB_PASSWORD="pass"
BACKUP_DIR="/var/backups/mysql"
DATE=$(date +\%F_\%T)

# Perform the backup
mysqldump -u $DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_DIR/backup_$DATE.sql

```
![alt text](<image/Screenshot from 2024-08-01 00-38-37.png>)
![alt text](<image/Screenshot from 2024-08-01 00-48-30.png>)