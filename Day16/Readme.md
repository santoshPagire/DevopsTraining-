## Project 1: Deploying Ansible
Deliverables:
### Control Node Setup:
Install Ansible on the control node.
```bash
 sudo apt update
 sudo apt install software-properties-common
 sudo add-apt-repository --yes --update ppa:ansible/ansible
 sudo apt install ansible
```
![alt text](<image/Screenshot from 2024-07-30 18-59-37.png>)
Configure SSH key-based authentication between the control node and managed nodes.
```bash
 ssh-agent bash
 ssh-add ~/.ssh/keypair.pem
```

### Managed Nodes Configuration:
Ensure all managed nodes are properly configured to be controlled by Ansible.
Verify connectivity and proper setup between the control node and managed nodes.
```yml
ansible -i inventory -m ping all
```
![alt text](<image/Screenshot from 2024-07-30 16-11-05.png>)

## Project 2: Ad-Hoc Ansible Commands
### Task Execution:
+ Execute commands to check disk usage across all managed nodes.
```bash
ansible target -m shell -a "df -h" -i inventory.ini
```
![alt text](<image/Screenshot from 2024-07-30 16-15-38.png>)
+ Restart a specific service on all managed nodes.
```bash
ansible target -i inventory.ini -b -m service -a "name=nginx state=restarted" 
```
![alt text](<image/Screenshot from 2024-07-30 16-30-09.png>)
+ Update all packages on a subset of managed nodes.
```bash
ansible target -i inventory.ini -b -m apt -a "update_cache=yes"
```
![alt text](<image/Screenshot from 2024-07-30 16-39-39.png>)
in above command we use '-b' to provide sudo permission.

## Project 3: Working with Ansible Inventories
### 1.Static Inventory:
+ Create a static inventory file with different groups for various environments and roles.
+ Verify that the inventory is correctly structured and accessible by Ansible.
> inventory.ini
```bash
[web]
target01 ansible_host=00.00.000.000 ansible_user=user ansible_ssh_private_key_file=/path/to/private/key

[db]
target02 ansible_host=00.00.000.000 ansible_user=user ansible_ssh_private_key_file=/path/to/private/key

```
### 2.Dynamic Inventory:
+ Implement a dynamic inventory script or use a dynamic inventory plugin.
+ Configure the dynamic inventory to categorize servers automatically based on predefined criteria.

## Project 4: Ansible Playbooks: The Basics
### Playbook Creation:
+ Write a playbook to install a specific package on all managed nodes.
> package.yml
```yml
---
- name: Install a specific package 
  hosts: target
  become: yes  
  tasks:
    - name : Install package
      apt: name=wget state=latest update_cache=true
```
> Use following command to run playbook
```yml
ansible-playbook package.yml -i inventory.ini
```
+ Create a playbook to configure a service with specific parameters.
> service.yml
```yml
---
- name: Configure service
  hosts: target
  become: yes  
  tasks:
    - name: Install nginx 
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Configure nginx with parameters
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf

```

> Use following command to run playbook
```yml
ansible-playbook service.yml -i inventory.ini
```

+ Develop a playbook to manage files, such as creating, deleting, and modifying files on managed nodes.
> files.yml
```yml
---
- name: Manage files 
  hosts: target
  become: yes  
  tasks:
    - name: Create file with content
      copy:
        dest: /tmp/file.txt
        content: |
          This is a random content added .
          This is another line.
        mode: '0644'

    - name: Create empty file
      file:
        path: /tmp/newfile.txt
        state: touch

    - name: Delete file
      file:
        path: /tmp/newfile.txt
        state: absent

    - name: Modify a file 
      lineinfile:
        path: /tmp/file.txt
        line: 'This is a new line added in file.'
        create: yes

```
> Use following command to run playbook
```yml
ansible-playbook files.yml -i inventory.ini
```
### Testing and Verification:
+ Test the playbooks to ensure they run successfully and perform the intended tasks.
+ Validate the changes made by the playbooks on the managed nodes.
![alt text](<image/Screenshot from 2024-07-30 17-04-27.png>)
![alt text](<image/Screenshot from 2024-07-30 17-23-21.png>)
![alt text](<image/Screenshot from 2024-07-30 17-25-38.png>)


## Project 5: Ansible Playbooks - Error Handling
### 1.Playbook with Error Handling:
+ Write a playbook that includes tasks likely to fail, such as starting a non-existent service or accessing a non-existent file.
+ Implement error handling strategies using modules like block, rescue, and always.
> ErrorHandle.yml
```yml
---
- name: Handle Errors
  hosts: target
  tasks:
  - name: Handle the error
    block:
      - name: Print a message
        ansible.builtin.debug:
          msg: 'I execute normally'

      - name: Force a failure
        ansible.builtin.command: /bin/false

      - name: Never print this
        ansible.builtin.debug:
          msg: 'I never execute, due to the above task failing, :-('
    rescue:
      - name: Print when errors
        ansible.builtin.debug:
          msg: 'I caught an error, can do stuff here to fix it, :-)'
    always:
       - name: Always do this
         ansible.builtin.debug:
           msg: "This always executes, :-)"
```
> Use following command to run playbook
```yml
ansible-playbook ErrorHandle -i inventory.ini
```
![alt text](<image/Screenshot from 2024-07-30 17-55-10.png>)

