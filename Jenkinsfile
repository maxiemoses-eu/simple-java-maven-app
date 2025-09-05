pipeline {
    agent any
    tools {
        maven 'Maven 3.10'
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
                    // Generates a unique tag for the Docker image using the build number.
                    def imageName = "simple-java-maven-app"
                    def imageTag = "${imageName}:${env.BUILD_NUMBER}"
                    
                    // Builds the Docker image using the Dockerfile in the current directory.
                    // The image is tagged with the generated tag.
                    echo "Building Docker image: ${imageTag}"
                    sh "docker build -t ${imageTag} ."
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
            echo 'Build and test successful! Artifact archived.'
        }
        failure {
            echo 'Build failed. Check the logs for details.'
        }
    }
}
