pipeline {

    agent{
    label 'agent-node'
    }

    parameters {
        string(name: 'VERSION', defaultValue: '1.0.0', description: 'Semantic version number')
    }

    environment {
        directory = '/home/ubuntu/workspace/app/petclinic/'
    }

    stages {

        stage('Clone') {
            steps {
                dir(env.directory){
                git branch: 'main', url: 'https://github.com/Aswin1118/java-spring-petclinic.git'
            }
            }
        }

        stage('create log file'){
            steps {
                sh ''' sudo touch /var/log/petclinic.log '''
            }
        }

        stage('Test') {
            steps {
                dir(env.directory){
                sh(script: './mvnw --batch-mode test')
            }
        }
    }

        stage('SonarQube Scan') {
            steps {
                dir(env.directory){
                sh '''
                mvn clean verify sonar:sonar \
                    -Dsonar.projectKey=sonar-jenkins \
                    -Dsonar.host.url=http://35.89.62.189:9000 \
                    -Dsonar.login=sqp_a52a92a70b0f6f1777c8133483a54bba58d0a54c
                '''
            }
            }
        }

        stage('Build') {
            steps {
                dir(env.directory){
                sh './mvnw package'
                }
            }
        }

        stage('Nexus-Artifact Upload'){
            steps{
                dir(env.directory + "target"){
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

        stage('Scan Image') {
            steps {
                sh 'sudo trivy image petclinic:${params.VERSION} >> ~/workspace/app/petclinic:${params.VERSION}.output.txt'
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
    }
}

