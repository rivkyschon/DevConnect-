pipeline {
    agent any

    environment {
        DOCKERFILE_PATH = 'Dockerfile'  // Path to your Dockerfile
        IMAGE_NAME = 'app'
        IMAGE_TAG = 'test'
        GCP_PROJECT = 'DevConnect-final-project'
        ARTIFACT_REGISTRY_REGION = 'us-central1'
        ARTIFACT_REGISTRY_REPO = 'us-central1-docker.pkg.dev/devconnect-project/rivkyschon-artfacts'
    }

    stages {
        stage('Checkout') {
            steps {
                cleanWs()
                checkout([$class: 'GitSCM',
                    branches: [[name: 'main']],  // Replace with your branch
                    userRemoteConfigs: [[url: 'git@github.com:rivkyschon/DevConnect-.git/',
                        credentialsId: 'jenkins']]])
                        
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                script {
                    dir("DevConnect Django CICD") {
                    def gitCommitMessage = sh(script: 'git log -1 --pretty=%B', returnStdout: true).trim()
                    def containerName = "django_app-${gitCommitMessage}"

                    // Stop and remove the existing container if it exists
                    sh "docker stop ${containerName} || true"
                    sh "docker rm ${containerName} || true"

                    // Build and run the new container
                    sh "docker build -t django_app:${gitCommitMessage} ."
                    sh "docker run -d --name ${containerName} -p 8000:8000 django_app:${gitCommitMessage}"
                    }
        
                    }
                }
            }
        stage('Test Application') {
            steps {
                 script {
                    echo 'Running Django tests...'
                    def gitCommitMessage = sh(script: 'git log -1 --pretty=%B', returnStdout: true).trim()
                    def containerName = "django_app-${gitCommitMessage}"

                    // Run Django tests within the Docker container
                    sh "docker exec ${containerName} python django_web_app/manage.py test"
        
                }
                
            }
            }
            stage('Push Docker Image to Artifact Registry') {
                steps {
                    script {
                        dir("DevConnect Django CICD") {
                            echo "Build and Push Docker Image..."
                            def gitCommitMessage = sh(script: 'git log -1 --pretty=%B', returnStdout: true).trim()
                            def containerName = "django_app-${gitCommitMessage}"
                            def imageTag = "us-central1-docker.pkg.dev/devconnect-project/rivkyschon-artfacts/django_app:${gitCommitMessage}"
                            sh "docker tag django_app:${gitCommitMessage} ${imageTag}"
                            // Authenticate with Google Cloud (if not already authenticated)
                            sh "gcloud auth configure-docker us-central1-docker.pkg.dev"

                            // Push the Docker image to Artifact Registry
                            sh "docker push ${imageTag}"
            }
        }
    }
}

}
                
        }
