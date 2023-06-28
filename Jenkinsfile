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
                    git branch: 'main', url: 'https://github.com/spring-projects/spring-petclinic.git'
            }
            }
        }

        stage('Build') {
            steps {
                dir(directory){
                    sh './mvnw package -Dmaven.test.skip=true'
                }
            }
        }

        stage('Test') {
            steps {
                dir(directory){
                    sh(script: './mvnw --batch-mode -Dmaven.test.failure.ignore=true test')
            }
        }
    }

        stage('SonarQube Scan') {
            steps {
                dir(directory){
                    withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        mvn sonar:sonar \
                            -Dsonar.projectKey=sonarqube-petclinic_app \
                            -Dsonar.organization=sonarqube-petclinic\
                            -Dsonar.host.url=https://sonarcloud.io \
                            -Dsonar.login=$SONAR_TOKEN
                    '''
                }
            }
        }
    }

        stage('Nexus-Artifact Upload'){
            steps{
                    withCredentials([usernamePassword(credentialsId: 'NEXUS-LOGIN', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    dir(directory + "target"){
                        sh '''
                            curl -v -u ${USERNAME}:${PASSWORD} \
                            --upload-file spring-petclinic-3.1.0-SNAPSHOT.jar \
                            http://18.237.155.109:8081/repository/maven-public/petclinic-jarfile/org/springframework/boot/petclinic/3.0.7/petclinic-3.0.7.jar
                        '''
                }
            }
        }
        }

        stage('Build Docker Image'){
            steps{
                dir("/home/ubuntu/workspace/APPLICATION PIPELINES/app/"){
                sh'sudo docker build -t petclinic:${params.VERSION} .'
                }
            }
        }

        stage('Scan Image') {
            steps {
                sh 'sudo trivy image petclinic:${params.VERSION} >> /home/ubuntu/petclinic:${params.VERSION}.output.txt'
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

        stage('Run Docker Image'){
            steps{
                sh 'sudo docker run -p 9090:8080 petclinic:${params.VERSION}'
            }
        }
    }
}

