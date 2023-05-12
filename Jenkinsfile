pipeline {

    agent{
    label 'agent-node'
    }

    stages {
        stage('Build') {
            steps {
                dir("/home/ubuntu/workspace/app/petclinic/"){
                sh 'mvn clean package'
                }
            }
        }

        stage('Test') {
            steps {
                dir("/home/ubuntu/workspace/app/petclinic/"){
                sh 'mvn test'
            }
        }
        }

        stage('Security Scans') {
            steps {
                sh 'trivy image -f jar:/home/ubuntu/workspace/app/petclinic/target/spring-petclinic-3.0.0-SNAPSHOT.jar'
            }
        }

        stage('Deploy Dev') {
            when {
                branch 'dev'
            }
            steps {
                // Deploy to Dev environment
                sh 'your-deployment-command dev'
            }
        }

        stage('Deploy Staging') {
            when {
                branch 'staging'
            }
            steps {
                // Deploy to Staging environment
                sh 'your-deployment-command staging'
            }
        }

        stage('Deploy Production') {
            when {
                branch 'master'
            }
            steps {
                // Deploy to Production environment
                sh 'your-deployment-command production'
            }
        }

        stage('Notify') {
            steps {
                // Send build status notifications
                // Use email, chat notifications, or any other preferred method
                // Example:
                sh 'send-notification-script success'
            }
        }
    }

    post {
        failure {
            // Send build failure notifications
            // Example:
            sh 'send-notification-script failure'
        }
    }
}

