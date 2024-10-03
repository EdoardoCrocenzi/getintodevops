pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }

        stage('Build image') {
            steps {
                script{
                    app = sh 'docker-compose build'
                }
            }
        }

        stage('Test image') {
            steps {
                script {
                    def IMAGE_ID = sh(script: "docker images | grep -E '^vulnhub' | awk '{print \$3}'", returnStdout: true).trim()
                    env.IMAGE_ID = IMAGE_ID
                }
            }
        }

        stage('Push image') {
            steps {
                script {
                    // Esegui il push manualmente dell'immagine Docker
                    docker.withRegistry('https://registry.hub.docker.com', 'git') {
                        sh 'docker tag dragonnest/nginx:${env.BUILD_NUMBER}'
                        sh 'docker push dragonnest/vulnhub:${env.BUILD_NUMBER}'
                        sh 'docker push dragonnest/vulnhub:latest'
                    }
                }
            }
        }
    }
}
