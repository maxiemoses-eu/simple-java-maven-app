pipeline {
    agent any
    tools {
        maven 'Maven 3.9'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clones the repository from the provided URL.
                git url: 'https://github.com/maxiemoses-eu/simple-java-maven-app.git'
            }
        }

        stage('Build & Test') {
            steps {
                // The 'mvn clean install' command compiles the code, runs the tests,
                // and packages the application into a JAR file. This single command
                // combines the build and test stages for better efficiency.
                sh 'mvn clean install'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Define the Docker Hub username and repository name
                    def dockerUser = "maxiemoses"
                    def imageName = "simple-java-maven-app"

                    // Generates a unique tag for the Docker image using the build number and Docker Hub username.
                    def imageTag = "${dockerUser}/${imageName}:${env.BUILD_NUMBER}"
                    
                    // Builds the Docker image using the Dockerfile in the current directory.
                    // The image is tagged with the generated tag.
                    echo "Building Docker image: ${imageTag}"
                    sh "docker build -t ${imageTag} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Define the Docker Hub username and repository name
                    def dockerUser = "maxiemoses"
                    def imageName = "simple-java-maven-app"

                    // Generates the tag used for pushing the image
                    def imageTag = "${dockerUser}/${imageName}:${env.BUILD_NUMBER}"

                    // Login to Docker Hub using stored credentials.
                    // 'dockerhub-credentiail' is the ID of the 'Username with password' credential in Jenkins.
                    echo "Logging in to Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentiail', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                    }

                    // Push the tagged Docker image to Docker Hub.
                    echo "Pushing Docker image: ${imageTag}"
                    sh "docker push ${imageTag}"
                }
            }
        }

        stage('Archive Artifact') {
            steps {
                // Archives the generated .jar file so it can be downloaded.
                archiveArtifacts artifacts: 'target/*.jar'
            }
        }
    }

    post {
        always {
            // Clean up the workspace to free up disk space.
            deleteDir()
        }
        success {
            echo 'Build, test, and push successful! Artifact archived.'
        }
        failure {
            echo 'Build failed. Check the logs for details.'
        }
    }
}
