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
                    docker.withRegistry('docker-hub-credentials') {
                        // Tagga l'immagine
                        sh "docker tag ubuntu dragonnest/hello:1.0"
                        // Push dell'immagine
                        sh "docker push dragonnest/hello:1.0"
                    }
                }
            }
        }
    }
}
