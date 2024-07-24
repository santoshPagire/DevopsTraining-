# Project Overview 
Create a private git repo that has a maven project. In Jenkins create 2 freestyle project, one to compile that maven project and other to test that maven project. Create a pipeline view of the project.

---

## Step 1. Private Git Repo

+ Creating private git repo
![alt text](<image/Screenshot from 2024-07-23 17-55-54.png>)

+ Generating personal access token
![alt text](<image/Screenshot from 2024-07-23 17-57-34.png>)

## Step 2. Compile maven project
+ Creating new freestyle project to Compile code using maven
![alt text](<image/Screenshot from 2024-07-23 18-23-56.png>)
+ Setting up git credentails in jenkins 
![alt text](<image/Screenshot from 2024-07-23 18-33-45.png>)
+ Configuring Freestyle Project 
![alt text](<image/Screenshot from 2024-07-23 17-35-29.png>)
+ Setup Maven Installation in Jenkins 
![alt text](<image/Screenshot from 2024-07-23 18-38-32.png>)
+ Setup Maven Build Steps `compile`
![alt text](<image/Screenshot from 2024-07-23 17-35-59.png>)
+ Build "Maven Compile" Project 
![alt text](<image/Screenshot from 2024-07-23 17-37-34.png>)
![alt text](<image/Screenshot from 2024-07-23 17-39-26.png>)



## Step 3. Test maven project
+ Creating new freestyle project to Test code using maven
![alt text](<image/Screenshot from 2024-07-23 18-24-42.png>)
+ Configuring Freestyle Project 
![alt text](<image/Screenshot from 2024-07-23 17-41-49.png>)
+ Setup Maven Build Steps `test`
![alt text](<image/Screenshot from 2024-07-23 17-42-12.png>)
+ Build "Maven Test" Project
![alt text](<image/Screenshot from 2024-07-23 17-42-51.png>)


## Step 4. Pipeline view

+ Create Pipeline View of Above mention project
+ Create new "build pipeline" in jenkins 
![alt text](<image/Screenshot from 2024-07-23 18-49-53.png>)
![alt text](<image/Screenshot from 2024-07-23 18-50-19.png>)
![alt text](<image/Screenshot from 2024-07-23 18-50-42.png>)
+ Output
![alt text](<image/Screenshot from 2024-07-23 17-33-50.png>)