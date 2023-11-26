pipeline {
    agent any

    environment {
        DOCKERFILE_PATH = 'Dockerfile'  // Path to your Dockerfile
        IMAGE_NAME = 'app'
        IMAGE_TAG = 'test'
        GCP_PROJECT = 'DevConnect-project'
        ARTIFACT_REGISTRY_REGION = 'us-central1'
        ARTIFACT_REGISTRY_REPO = 'us-central1-docker.pkg.dev/devconnect-project/rivkyschon-artfacts'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: 'main']],  // Replace with your branch
                    userRemoteConfigs: [[url: 'git@github.com:rivkyschon/DevConnect-.git',
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
        
                    // // Define the URL of your app
                    def externalIP = sh(script: 'curl -s http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip -H "Metadata-Flavor: Google"', returnStdout: true).trim()
                    def appURL = "http://${externalIP}:8000"

                    //def appUrl = 'http://172.17.0.2:8000'  // Replace with your app's URL

                    // // Check for a 200(OK) response
                    def responseCode = sh(script: "curl -s -o /dev/null -w '%{http_code}' $appURL", returnStatus: true).trim()
                    echo "${responseCode}"
                    // if (responseCode == '200') {
                    //     echo "Application is accessible with a 200(OK) response."
                    // } else {
                    //     error "Failed to get a 200(OK) response. Pipeline will be marked as failed."
                    // }
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
                            def imageTag = "me-west1-docker.pkg.dev/devconnect-final-project/rivkyschon-artifacts/django_app:${gitCommitMessage}"
                            sh "docker tag django_app:${gitCommitMessage} ${imageTag}"
                            // Authenticate with Google Cloud (if not already authenticated)
                            sh "gcloud auth configure-docker me-west1-docker.pkg.dev"

                            // Push the Docker image to Artifact Registry
                            sh "docker push ${imageTag}"
            }
        }
    }
}

}
                
        }

// pipeline {
//     agent any

//     triggers {
//         pollSCM('*/10 * * * *')
//     }

//     environment {
//         IMAGE_NAME = 'django'
//         ARTIFACT_URL = 'me-west1-docker.pkg.dev/devconnect-final-project/rivky-rizel-artifacts/dev_connect'
//         COMMIT = sh(script: 'git log -1 --pretty=%B', returnStdout: true).trim()
//     }

//     stages {
//         stage('Build') {
//             steps {
//                 script {
//                     sh 'docker build -t ${IMAGE_NAME}:${COMMIT} .'
//                 }
//             }
//         }

//         stage('Test') {
//             steps {
//                 script {
//                     sh 'python django_web_app/manage.py test'
//                 }
//             }
//         }

//         stage('Push to Artifact Registry') {
//             when {
//                 expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
//             }
//             steps {
//                 script {
//                     // Push the image to the Artifact Registry with the commit message as the version
//                     sh 'gcloud auth configure-docker me-west1-docker.pkg.dev'
//                     sh 'docker tag ${IMAGE_NAME}:${COMMIT} ${ARTIFACT_URL}:${COMMIT}'
//                     sh 'docker push ${ARTIFACT_URL}:${COMMIT}'
//                 }
//             }
//         }

//         stage('Deploy to Production') {
//             when {
//                 expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
//             }
//             steps {
//                 script {
//                     // Your deployment steps here (e.g., using your deploy.sh script)
//                     sh './deploy.sh'
//                 }
//             }
//         }
//     }

//     post {
//         success {
//             echo 'Pipeline succeeded!'
//         }
//         failure {
//             echo 'the pipeline failed :('
//         }
//     }

//     post {
//         always {
//             // Clean up resources and workspace
//             cleanWs()
//         }
//     }
// }
