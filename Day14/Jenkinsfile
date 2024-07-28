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