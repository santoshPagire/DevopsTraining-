## Multi-Branch Project
### Project Overview
+ Create a simple Java Maven project.
+ Version-control the project using Git with multiple branches.
+ Set up Jenkins multi-branch pipeline for automated build and deployment.

## Project Deliverables
### 1.Git Repository:
+ Local Git repository initialized.
```bash
git init
```
![alt text](<image/Screenshot from 2024-07-27 22-01-11.png>)
+ Branches: development, staging, and production.
```bash
git branch development
git branch staging
git branch production
```
+ Repository pushed to remote Git server (e.g., GitHub, GitLab, Bitbucket).
![alt text](<image/Screenshot from 2024-07-27 22-03-47.png>)
### 2.Maven Project:
+ Simple Java Maven project created (HelloWorld application).
> Create file src/main/java/com/example/App.java
```bash
package com.example;

public class App {
    public static void main(String[] args) {
        System.out.println("Hello World !");
    }
}

```
+ pom.xml with dependencies and build configurations.
```bash
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/POM/4.0.0/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>my-java-app</artifactId>
    <version>1.0-SNAPSHOT</version>
    <properties>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
    </properties>
</project>

```
### 3.Jenkins Setup:
+ Multi-branch pipeline job configured in Jenkins.
![alt text](<image/Screenshot from 2024-07-27 22-15-01.png>)
+ Jenkinsfile defining build and deployment steps.
```bash
pipeline {
    agent any
    tools{
        maven 'maven-3.9.8'
    }
 
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/santoshPagire/Maven_app.git', branch: env.BRANCH
            }
        }
 
        stage('Build') {
            steps {
                script {
                    echo "Building pull request branch: ${env.BRANCH}"
                    sh 'mvn clean install'   
                }
            }
        }
 
        stage('Test') {
            steps {
                script {
                    echo "Running tests on pull request branch: ${env.BRANCH}"
                    sh 'mvn test'
                }
            }
        }

        stage('Output') {
            steps{
                script{
                    sh 'java src/main/java/com/example/App.java'
                }
            }
        }
        stage('Archive Artifacts') {
            steps {
        
                archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
            }
        }
    }
 
    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Pipeline succeeded.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
```
+ Environment variables managed using Jenkins environment variable settings.
![alt text](<image/Screenshot from 2024-07-27 22-14-04.png>)
+ Output
![alt text](<image/Screenshot from 2024-07-27 22-17-00.png>)
