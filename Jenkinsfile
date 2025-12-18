pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Shell Lint') {
            steps {
                sh 'shellcheck hello.sh'
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

        stage('Quality Gate') {
            steps {
                script {
                    def qg = waitForQualityGate()
                    if (qg.status != 'OK') {
                        error "❌ Quality Gate Failed: ${qg.status}"
                    }
                }
            }
        }

        stage('Finish') {
            steps {
                echo "✅ CI Pipeline completed successfully"
            }
        }
    }
}
