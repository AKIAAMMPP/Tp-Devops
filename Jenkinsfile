pipeline {
    agent any

    environment {
        // Définir le JAVA_HOME et le PATH pour Java 25
        JAVA_HOME = '/opt/java/jdk-25.0.0.36'
        PATH = "${JAVA_HOME}/bin:${env.PATH}"
        SONARQUBE_SERVER = 'SonarQube'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/AKIAAMMPP/Tp-Devops.git'
            }
        }

        stage('Debug Java') {
            steps {
                echo '=== Vérification de la version de Java et Maven ==='
                sh 'java -version'
                sh 'echo $JAVA_HOME'
                sh 'which java'
                sh './mvnw -v'
            }
        }

        stage('Prepare') {
            steps {
                sh 'chmod +x mvnw'
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
        success {
            echo 'Build et tests terminés avec succès !'
        }
        failure {
            echo 'Le build a échoué. Vérifiez les logs.'
        }
    }
}
