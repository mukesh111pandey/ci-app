pipeline {
    agent any

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
                        -Dsonar.sources=. \
                        -Dsonar.login=$SONAR_AUTH_TOKEN
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
                echo "🚀 CI + Docker + CD completed successfully"
            }
        }
    }
}
