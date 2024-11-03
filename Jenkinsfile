pipeline {
    agent any

    // Clone Git Repository: Clones the repository from GitHub.
    stages {
        stage('Clone Git Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/Dima-Go/Contacts-Project.git'
            }
        }
    
    // Build Docker Image: Builds a Docker image using the Dockerfile in your repository.
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t contacts-project .'
                }
            }

    // Run Docker Compose: Runs the appropriate docker-compose.yml file based on the selected DATABASE_TYPE parameter.
        stage('Run Docker Compose') {
            steps {
                sh 'docker-compose down'
                    if (params.DATABASE_TYPE == 'MONGO') {
                        sh 'docker-compose -f docker-compose-mongo.yml up -d'
                    } else {
                        sh 'docker-compose -f docker-compose-mysql.yml up -d'
                    }
                }
            }
    // Push Docker Image to Docker Hub: Pushes the built image to Docker Hub using the credentials defined in Jenkins.
        stage('Push Docker Image to Docker Hub') {
            environment {
                DOCKER = credentials('docker-creds')
            }
            steps {
                sh 'docker login -u ${DOCKER_USR} -p ${DOCKER_PSW}'
                sh 'docker tag contacts-project dimagolde/contacts-project'
                sh 'docker push dimagolde/contacts-project'                
            }
        }
    }
}

// Configuration Details:

// Select the database type: 
// The choices for DATABASE_TYPE are 'MONGO' or 'MYSQL'

// Docker Hub Credentials:
// In Jenkins, go to Manage Jenkins > Manage Credentials, and add a credential with ID 'docker-creds'. This will hold your Docker Hub username and password.

