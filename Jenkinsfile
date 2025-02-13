pipeline {
    agent any 
    stages {
        stage('parallel Execution') {
            parallel {
                        stage('checkout') { 
                            steps {
                                echo 'this is for the test purpose'
                            }
                        }
                
        
                        stage('build') { 
                            steps {
                                sh 'mvn clean install' 
                            }
                        }
                        
            }   
        }
    }
}
