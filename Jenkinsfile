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
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        sh "docker tag ${env.IMAGE_ID} dragonnest/nginx_vuln:${env.BUILD_NUMBER}"
                        sh "docker push dragonnest/nginx_vuln:${env.BUILD_NUMBER}"
                        sh "docker push dragonnest/nginx_vuln:latest"
                    }
                }
            }
        }
    }
}
