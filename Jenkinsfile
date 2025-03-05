pipeline {
    agent { label 'ecr' }
    environment {
        AWS_REGION = 'us-east-1' 
        ECR_REPO = '311141522357.dkr.ecr.us-east-1.amazonaws.com/new-ecr'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Sandhyachinnu26/java-war-repo.git'
            }
        }

        stage('Build Java Application') {
            steps {
                sh 'mvn clean package -DskipTests' 
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "sudo docker build -t new-ecr ."
            }
        }

        stage('Push Image to AWS ECR') {
            steps {
                script {
                    sh """
                    aws ecr get-login-password --region ${AWS_REGION} | sudo docker login --username AWS --password-stdin ${ECR_REPO}
                    """

                    sh """
                    sudo docker tag new-ecr:latest ${ECR_REPO}:latest
                    """

                    sh """
                    sudo docker push ${ECR_REPO}:latest
                    """
                }
            }
        }
    }
}
