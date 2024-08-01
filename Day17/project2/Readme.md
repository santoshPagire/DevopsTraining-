# Project 02
## Deliverables
### 1.Ansible Inventory File
+ Content: Defines the database server and application server instances, including their IP addresses and connection details.
> Filename: inventory.ini
```yml

web_server ansible_host=00.00.00.00 ansible_connection=ssh ansible_user=user ansible_ssh_private_key_file=/path/to/key.pem


db_server ansible_host=00.00.00.00 ansible_connection=ssh ansible_user=user ansible_ssh_private_key_file=/path/to/key.pem
```
![alt text](<images/Screenshot from 2024-08-01 16-44-29.png>)
### 2.Ansible Playbook

+ Content: Automates:
+ The deployment and configuration of the Mysql database server.
+ The setup and configuration of the web server.
+ The deployment of the web application and its configuration to connect to the database.
> Filename: deploy_multitier_stack.yml
```yml
- name: Deploy and configure MySQL database
  hosts: db_server
  become: yes
  vars:
    db_name: "dbname"
    db_user: "dbusername"
    db_password: "pass123"

  tasks:
  - name: Install MySQL server
    apt:
      update_cache: yes
      name: "{{ item }}"
      state: present
    with_items:
    - mysql-server
    - mysql-client
    - python3-mysqldb
    - libmysqlclient-dev

  - name: Ensure MySQL service is running
    service:
      name: mysql
      state: started
      enabled: yes

  - name: Create MySQL user
    mysql_user:
      name: "{{ db_user }}"
      password: "{{ db_password }}"
      priv: '*.*:ALL'
      host: '%'
      state: present

  - name: Create MySQL database
    mysql_db:
      name: "{{ db_name }}"
      state: present

- name: Deploy and configure web server and application
  hosts: web_server
  become: yes

  vars:
    db_host: "host_ip"
    db_name: "dbname"
    db_user: "dbusername"
    db_password: "pass123"

  tasks:
  - name: Install web server
    apt:
      name: nginx
      state: present
      update_cache: yes

  - name: Ensure web server is running
    service:
      name: nginx
      state: started
      enabled: yes

  - name: Deploy application files
    copy:
      src: files/index.html
      dest: /var/www/html/index.html

  - name: Configure application
    template:
      src: templates/app_config.php.j2
      dest: /var/www/html/app_config.php

  - name: Restart web server to apply changes
    service:
      name: nginx
      state: restarted

```
![alt text](<images/Screenshot from 2024-08-01 17-11-15.png>)
![alt text](<images/Screenshot from 2024-08-01 17-11-47.png>)
### 3.Jinja2 Template

+ Content: Defines a configuration file for the web application that includes placeholders for dynamic values such as database connection details.
> Filename: templates/app_config.php.j2
```bash
<?php
$host = '{{ db_host }}';
$dbname = '{{ db_name }}';
$user = '{{ db_user }}';
$password = '{{ db_password }}';

// Create a new PDO instance
try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
    // Set the PDO error mode to exception
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}
?>
```
### 4.Application Files
+ Content: Static or basic dynamic content served by the web application
> Filename: files/index.html
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Application</title>
</head>
<body>
    <h1>Welcome to My Application</h1>
    <p>This is a sample web application.</p>
</body>
</html>
```
## Output:
![alt text](<images/Screenshot from 2024-08-01 17-21-08.png>)
![alt text](<images/Screenshot from 2024-08-01 17-14-27.png>)