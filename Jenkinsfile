pipeline {
  
    agent any
    tools {nodejs "npm"}
    environment {
        DOCKERHUB_CREDENTIALS= credentials('zhgs08')
    } 

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from GitHub repository
                git branch: 'main', url: 'https://github.com/zhgs08/cicd-pipeline.git'
            }
        }
        
        stage('Build App') {
            steps {
                sh '''chmod +x scripts/build.sh
                ./scripts/build.sh '''
            }
        }
 
        stage('Test App') {
            steps {
                sh './scripts/test.sh'
            }
        }
        
        stage('Build and Push Docker Image') {
            steps {
                script {
                    def nodeAppDockerfilePath = './Dockerfile'
                    sh "docker build -t zhgs08/jenkins_cicd_image:$BUILD_NUMBER -f ${nodeAppDockerfilePath} ."
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin docker.io'
                    sh 'docker push zhgs08/jenkins_cicd_image:$BUILD_NUMBER'
                    sh 'docker logout'
                    }
                }
            }
        }
    }
