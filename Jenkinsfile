pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'  // ignorer les tests si nécessaire
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t monimage:1.0 .'
            }
        }
    }
}
