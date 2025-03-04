pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'  // Change this to your AWS region
        IMAGE_NAME = 'java-app'  // Replace with your Docker image name
        ECR_REPO = '311141522357.dkr.ecr.us-east-1.amazonaws.com/new-ecr:latest'  // Replace with your ECR repository name
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Sandhyachinnu26/java-war-repo.git'
            }
        }

        stage('Build Java Application') {
            steps {
                sh '''
                mvn clean package -DskipTests
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                sudo docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Push Image to AWS ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
                sudo docker tag $IMAGE_NAME:latest $ECR_REPO:latest
                sudo docker push $ECR_REPO:latest
                '''
            }
        }
    }
}
