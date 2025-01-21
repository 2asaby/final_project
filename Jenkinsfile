pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "final_project:latest"
        DOCKER_REPO = "2asaby/final_project"
        DOCKER_CREDENTIALS_ID = "dockerhub-mylab" // Update with your Jenkins credentials ID for Docker Hub
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building the Java application'
                sh 'chmod +x ./mvnw'
                sh './mvnw clean package'
            }
        }
        stage ('test') {
            steps {
                echo 'Testing the Java application'
                sh './mvnw test'
            }
        }
        stage ('Docker Build and Push') {
            steps {
                script {
                    echo 'Building and pushing to Docker hub'
                    docker.build("2asaby/final_project:jenkins-test")

                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-mylab') {
                        docker.image("2asaby/final_project:jenkins-test").push()
                    }
                }
            }        
        }
    }
}
