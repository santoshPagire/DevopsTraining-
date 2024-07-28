# Project 01
## 1.GitHub Repository containing: 
+ The source code of a simple Java application.
>  Create App.java and add following content
```bash
package com.example;

public class App {
    public static void main(String[] args) {
        System.out.println("Hello World");
    }
}
```
+ A Dockerfile for building the Docker image.
> Create Dockerfile with following content
```yml
FROM openjdk:11
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN javac App.java
CMD ["java", "App.java"]
```

## 2.Jenkins Pipeline Script: A Jenkinsfile (pipeline script) that:
+ Clones the GitHub repository.
![alt text](<image/Screenshot from 2024-07-27 20-40-32.png>)
+ Builds the Docker image.
![alt text](<image/Screenshot from 2024-07-27 20-02-27.png>)
+ Pushes the Docker image to DockerHub.
![alt text](<image/Screenshot from 2024-07-27 20-02-53.png>)
+ Deploys a container using the pushed image.
![alt text](<image/Screenshot from 2024-07-27 20-03-24.png>)
> Create Jenkinsfile
```bash
pipeline {
    agent any
    environment {
        registry = 'docker.io'  
        registryCredential = 'docker' 
    }
 
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/santoshPagire/Task_Day14.git', branch: 'main'
            }
        }

        stage('build image') {
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        def customImage = docker.build("santoshpagire/myjava-app:${env.BUILD_ID}")
                        customImage.push()
                        

                    }
                    
                }
            }
        }

        stage('Deploy Container') {
            steps {
                
                script {
                    docker.withRegistry('', registryCredential) {
                        def runContainer = docker.image("santoshpagire/myjava-app:${env.BUILD_ID}").run('--name mynew-container -d')
                        echo "Container ID: ${runContainer.id}"
                    }
                }
            }
        }

        stage('Output') {
            steps{
                script{
                    sh 'java App.java'
                }
            }
        }
        
    }
 
  
}
```
## 3.DockerHub Repository: 
+ A DockerHub repository where the Docker images will be stored.
![alt text](<image/Screenshot from 2024-07-27 20-14-40.png>)
## 4.Jenkins Setup:
+ Jenkins installed and configured on a local Ubuntu machine.
![alt text](<image/Screenshot from 2024-07-27 20-11-39.png>)
+ Required plugins installed (e.g., Git, Docker, Pipeline).
![alt text](<image/Screenshot from 2024-07-27 20-13-23.png>)

## 5. Explaination:
+ Above Jenkins pipeline first Clone repository which contain Jenkinsfile, App.java file and Dockerfile.
+ Jenkinsfile first clone repo then create docker image using Dockerfile.
+ Then Push this image to github and then deploy container by using than that image. 
![alt text](<image/Screenshot from 2024-07-27 20-00-58.png>)