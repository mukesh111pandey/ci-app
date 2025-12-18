pipeline {
    agent any

    tools {
        sonarScanner 'sonar-scanner'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/mukesh111pandey/ci-app.git'
            }
        }

        stage('Run Script') {
            steps {
                sh 'chmod +x hello.sh'
                sh './hello.sh'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh '''
                    sonar-scanner \
                    -Dsonar.projectKey=ci-app \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=http://localhost:9000
                    '''
                }
            }
        }
    }
}
