pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }

        stage('Build image'){
            steps{
                sh "docker build /var/lib/jenkins/workspace/prova/"
            }
        }
        
        stage('Test image') {
            steps {
                script {
                    def IMAGE_ID = sh(script: "docker images | grep -E '^httpd' | awk '{print \$3}'", returnStdout: true).trim()
                    env.IMAGE_ID = IMAGE_ID
                }
            }
        }

        stage('Push image') {
            steps {
                script {
                    // Esegui il push manualmente dell'immagine Docker
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        sh "docker tag vulnhub/httpd dragonnest/httpd:${env.BUILD_NUMBER}"
                        sh "docker push dragonnest/httpd_vuln:${env.BUILD_NUMBER}"
                        sh "docker push dragonnest/httpd_vuln:latest"
                    }
                }
            }
        }
    }
}
