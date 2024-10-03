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
                script {
                    app = sh(script: "docker-compose up /home/edoardo/vulhub/nginx/CVE-2017-7529/")
                }
            }
        }

        stage('Test image') {
            steps {
                script {
                    def IMAGE_ID = sh(script: "docker images | grep -E '^vulnhub' | awk '{print \$3}'", returnStdout: true).trim()
                    env.IMAGE_ID = IMAGE_ID
                    app.inside {
                        sh 'echo "Testing the app"'
                        // Inserisci qui i tuoi test
                    }
                }
            }
        }

        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        app.push('latest')
                    }
                }
            }
        }
    }
}
