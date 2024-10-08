pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }

        stage('SonarQube Analysis'){
            def scannerHome = tool 'provaprova'
            withSonarQubeEnv(){
                sh "./sonar-scanner/bin/sonar-scanner"
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
                    def IMAGE_ID = sh(script: "docker images | grep -E '^sasanlabs' | awk '{print \$3}'", returnStdout: true).trim()
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
                    docker.withRegistry('https://registry.hub.docker.com','docker-hub-credentials') {
                        // Tagga l'immagine
                        sh "docker tag sasanlabs registry.hub.docker.com/dragonnest/pippo:1.0"
                        // Push dell'immagine
                        sh "docker push registry.hub.docker.com/dragonnest/pippo:1.0"
                    }
                }
            }
        }
    }
}
