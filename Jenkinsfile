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
                    def IMAGE_ID = sh(script: "docker images | grep -E '^ubuntu' | awk '{print \$3}'", returnStdout: true).trim()
                    env.IMAGE_ID = IMAGE_ID
                }
            }
        }

        stage('Get Image Vuln'){
            steps{
                 getImageVulnsFromQualys imageIds: env.IMAGE_ID, useGlobalConfig: true   
            }
        }

        stage('Push image') {
            steps {
                script {
                    // Esegui il push manualmente dell'immagine Docker
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        sh "docker tag ubuntu dragonnest/ubuntu_secure:${env.BUILD_NUMBER}"
                        sh "docker push dragonnest/ubuntu_secure:${env.BUILD_NUMBER}"
                        sh "docker push dragonnest/ubuntu_secure:latest"
                    }
                }
            }
        }
    }
}
