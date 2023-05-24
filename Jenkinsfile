pipeline {

    agent{
    label 'agent-node'
    }

    parameters {
        string(name: 'VERSION', defaultValue: '1.0.0', description: 'Semantic version number')
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
                dir("/home/ubuntu/workspace/app/"){
                sh'docker build -t petclinic:${params.VERSION} .'
                }
            }
        }

        stage('Push to DockerHub'){
            steps{
                sh'''
                docker tag petclinic:${params.VERSION} aswinvj/petclinic:${params.VERSION}
                docker push aswinvj/petclinic:${params.VERSION}
                '''
            }
        }

        stage('Deploy in EKS Cluster'){
            steps{
                sh''
            }
        }
    }
}

