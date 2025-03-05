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

        stage('Pull Image from ECR') {
            agent { label 'san' }  // Running this stage on another agent
            steps {
                sh '''
                aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 311141522357.dkr.ecr.us-east-1.amazonaws.com
                sudo docker pull 311141522357.dkr.ecr.us-east-1.amazonaws.com/new-ecr:latest
                '''
            }
        }

        stage('Restart Tomcat Container') {
            agent { label 'san' }  // Running this stage on another agent
            steps {
                sh '''
                sudo docker stop tomcat_container || true
                sudo docker rm tomcat_container || true
                sudo docker run -d --name tomcat_container -p 9090:8080 311141522357.dkr.ecr.us-east-1.amazonaws.com/new-ecr:latest
                '''
            }
        }
    }
