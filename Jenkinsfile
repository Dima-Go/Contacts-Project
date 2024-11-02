pipeline {
    agent any

    parameters {
        choice(name: 'DATABASE_TYPE', choices: ['MONGO', 'MYSQL'], description: 'Select the database type')
        string(name: 'DOCKERHUB_USERNAME', defaultValue: 'your-dockerhub-username', description: 'Docker Hub Username')
        string(name: 'DOCKERHUB_PASSWORD', defaultValue: 'your-dockerhub-password', description: 'Docker Hub Password')
        string(name: 'DOCKERHUB_REPO', defaultValue: 'your-dockerhub-repo', description: 'Docker Hub Repo Name')
    }

    environment {
        DOCKER_IMAGE = "${params.DOCKERHUB_REPO}:${env.BUILD_NUMBER}"
    }

    // Clone Git Repository: Clones the repository from GitHub.
    stages {
        stage('Clone Git Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Dima-Go/Contacts-Project.git'
            }
        }
    // Build Docker Image: Builds a Docker image using the Dockerfile in your repository.
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t <name of the image:build#> .'
                    // docker.build(env.DOCKER_IMAGE)
                }
            }
        }
    // Push Docker Image to Docker Hub: Pushes the built image to Docker Hub using the credentials defined in Jenkins.
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        docker.image(env.DOCKER_IMAGE).push()
                    }
                }
            }
        }
    // Run Docker Compose: Runs the appropriate docker-compose.yml file based on the selected DATABASE_TYPE parameter.
        stage('Run Docker Compose') {
            steps {
                script {
                    sh 'docker-compose down'
                    if (params.DATABASE_TYPE == 'MONGO') {
                        sh 'docker-compose -f docker-compose-mongo.yml up -d'
                    } else {
                        sh 'docker-compose -f docker-compose-mysql.yml up -d'
                    }
                }
            }
        }
    }
    // Cleanup: Cleans up Docker containers and images after the pipeline finishes.
    post {
        always {
            echo 'Cleaning up Docker containers and images...'
            sh 'docker-compose down'
        }
    }
}

// Configuration Details

// Docker Hub Credentials:
// In Jenkins, go to Manage Jenkins > Manage Credentials, and add a credential with ID docker-hub-credentials. This will hold your Docker Hub username and password.

// Docker Compose Files:
// You should have two Docker Compose files: docker-compose-mongo.yml and docker-compose-mysql.yml, where each is configured to run your app with the appropriate database (MongoDB or MySQL).

// Setting up Jenkins:
// Make sure Jenkins is installed with the required plugins: Docker Pipeline, Git, and Docker.
