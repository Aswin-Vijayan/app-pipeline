pipeline {

    agent{
    label 'agent-node'
    }

    parameters {
        string(name: 'VERSION', defaultValue: '1.0.0', description: 'Semantic version number')
    }

    environment {
        PATH = "$PATH:/opt/apache-maven-3.9.3/bin"
        directory = '/home/ubuntu/workspace/APPLICATION PIPELINES/app/petclinic/'
    }

    stages {

        stage('Clone') {
            steps {
                dir(directory){
                    git branch: 'main', url: 'https://github.com/techiescamp/java-spring-petclinic.git'
            }
            }
        }
        stage('Create AMI') {
            steps {
                dir("/home/ubuntu/workspace/APPLICATION PIPELINES/app/"){
                sh 'packer build -var "consul_server_ip=44.230.25.63" vm.pkr.hcl'
                }
            }
        }
    }
}

        