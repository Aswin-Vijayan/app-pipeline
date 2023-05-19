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
                sh './mvnw package'
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
    }
}

