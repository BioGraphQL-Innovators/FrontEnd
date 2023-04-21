pipeline {
    agent any
    
    tools {
        nodejs "NodeJS"
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/BioGraphQL-Innovators/FrontEnd.git'
            }
        }
        stage('Install') {
            steps {
                dir('nurse-app') {
                    script {
                        sh 'npm install'
                    }
                }
            }
        }
        stage('Build') {
            steps {
                dir('nurse-app') {
                    script {
                        sh 'npm run build'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                dir('nurse-app') {
                    script {
                        sh 'npm run test'
                    }
                }
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    docker.build("aunreza/biograph-innovators:${env.BUILD_ID}")
                }
            }
        }
        stage('Docker Login') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: '4193ece9-7121-4dfc-9a68-74c8460c278a', passwordVariable: 'dockerhub_pwd', usernameVariable: 'dockerhub_usr')]) 
                    {
                        sh "docker login --username $dockerhub_usr --password $dockerhub_pwd"
                    }
                }
            }
        }
        stage("Docker Push") {
               steps {
                   script {
                            sh "docker push aunreza/biograph-innovators:${env.BUILD_ID}"
                         }
               }
          }
        stage("Dev Enviroment") {
            steps {
                   script {
                            sh "docker run -p 8081:5173 aunreza/biograph-innovators:${env.BUILD_ID}"
                         }
               }
        }
    }   
}