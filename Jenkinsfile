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

        stage('Build') {
            steps {
                // Runs the Maven build command. The -DskipTests flag is used
                // to separate the build from the test stage for better pipeline visibility.
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Test') {
            steps {
                // Executes the unit tests for the project.
                sh 'mvn test'
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
