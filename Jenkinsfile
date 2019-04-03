pipeline {
    agent any

    environment {
        ARTIFACT_NAME = 'spring-boot-hello-world-1.0-SNAPSHOT.jar'
        GIT_REPO="git@github.com:suleymanyigit/spring-boot-hello-world.git"
        GIT_REPO_2="git@github.com:suleymanyigit/trendcase.git"
        GIT_BRANCH="master"
        ARTIFACT_FOLDER = "target"
        service='case'
        registry='suleymanyigit'
        version='1.0.0'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }
        stage('Build Source Code'){
            steps{
                sh 'mvn -U clean package'
            }
        }

        stage('Checkout 2') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO_2}"
            }
        }
                        
        stage('Build Docker Image') {
            steps{
               sh "docker build --rm -t ${registry}/${service}:1.0.0 -t ${registry}/${service}:${ARTIFACT_NAME} ."
            }
         }
         
        stage('Push Docker Image') {
            steps {
               sh "docker push ${registry}/${service}:${ARTIFACT_NAME}"
               sh "docker push ${registry}/${service}:1.0.0"
            }
        }
        stage('Docker Run') {
            steps {
               sh "ssh root@10.156.0.3 'docker rm -f \$(docker ps -a -q) && docker run -d -p 8080:8080 suleymanyigit/case:1.0.0'"
               sh "ssh root@10.156.0.4 'docker rm -f \$(docker ps -a -q) && docker run -d -p 8080:8080 suleymanyigit/case:1.0.0'"
            }
               
        }
    }

}
