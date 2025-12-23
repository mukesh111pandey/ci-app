pipeline {
    agent any

    environment {
        // Jenkins Credentials ID (Secret Text)
        SONAR_TOKEN = credentials('sonar-token')
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run Script') {
            steps {
                sh 'bash hello.sh'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh '''
                        sonar-scanner \
                        -Dsonar.projectKey=ci-app \
                        -Dsonar.projectName=ci-app \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://localhost:9000 \
                        -Dsonar.login=$SONAR_TOKEN
                    '''
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t ci-app:latest .'
            }
        }

        stage('Docker Run (CD)') {
            steps {
                sh '''
                    docker rm -f ci-app-container || true
                    docker run -d --name ci-app-container ci-app:latest
                '''
            }
        }

        stage('Finish') {
            steps {
                echo "🚀 CI + SonarQube + Docker + CD completed successfully"
            }
        }
    }
}
