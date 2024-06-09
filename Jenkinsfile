pipeline {
    agent any
    triggers {
        pollSCM('* * * * *')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/ernest-emmanuel-utibe/Test-Deployment.git'
            }
        }
        stage('Build') {
            steps {
                sh './mvnw clean install'
            }
        }
        stage('Docker Build and Push') {
            steps {
                script {
                    def dockerImage = docker.build("samuel007/testingd:${env.BUILD_ID}")
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials-id') {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                sshagent(credentials: ['ec2-ssh-credentials-id']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ec2-user@3.79.29.66 "docker pull samuel007/testingd:${BUILD_ID} && docker stop myapp || true && docker rm myapp || true && docker run -d --name myapp -p 8080:8080 samuel007/testingd:${BUILD_ID}"
                    '''
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
