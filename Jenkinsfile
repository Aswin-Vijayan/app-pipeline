pipeline {

    agent{
    label 'agent-node'
    }

    stages {

        stage('Clone') {
            steps {
                dir("/home/ubuntu/workspace/app/petclinic/"){
                git branch: 'main', url: 'https://github.com/spring-projects/spring-petclinic.git'
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

        stage('SonarQube Scan') {
            steps {
                dir("/home/ubuntu/workspace/app/"){
                sh ''
            }
            }
        }

        stage('Build') {
            steps {
                dir("/home/ubuntu/workspace/app/petclinic/"){
                sh 'mvn clean package'
                }
            }
        }

        stage('Nexus-Artifact Upload'){
            steps{
                dir("/home/ubuntu/workspace/app/petclinic/target"){
                sh''
                }
            }
        }

        stage('Build Docker Image'){
            steps{
                sh''
            }
        }

        stage('Push to DockerHub'){
            steps{
                sh''
            }
        }

        stage('Deploy in EKS Cluster'){
            steps{
                sh''
            }
        }

        stage('Notify Slack') {
            steps {
                script {
                    def slackWebhookUrl = "<SLACK_WEBHOOK_URL>"
                    def successMessage = "Your CI/CD pipeline has completed successfully!"
                    def errorMessage = "Your CI/CD pipeline has encountered an error!"

                    try {
            // Your pipeline steps here
            
            // If everything is successful
                    slackNotification(slackWebhookUrl, successMessage)
                    } catch (Exception e) {
            // Handle error
            
            // If an error occurs
                    slackNotification(slackWebhookUrl, errorMessage)
                    error("CI/CD pipeline failed due to an error.")
            }
        }
    }
}

            def slackNotification(webhookUrl, message) {
            sh """
            curl -X POST -H 'Content-type: application/json' --data '{"text": "${message}"}' "${webhookUrl}"
            """
        }
    }
}

