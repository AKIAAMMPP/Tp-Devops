pipeline {
    agent any

    tools {
        maven 'Maven3'  // Nom de ton Maven installé dans Jenkins
        jdk 'JDK25'     // Nom de ton JDK configuré dans Jenkins
    }

    environment {
        SONARQUBE_SERVER = 'SonarQube' // Nom que tu as donné dans Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/spring-projects/spring-petclinic.git'
            }
        }

        stage('Build') {
            steps {
                sh './mvnw clean install -DskipTests'
            }
        }

        stage('Test') {
            steps {
                sh './mvnw test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE_SERVER}") {
                    sh './mvnw sonar:sonar -Dsonar.projectKey=petclinic'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            junit '**/target/surefire-reports/*.xml'
        }
    }
}
