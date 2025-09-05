pipeline {
    agent any
    maven 9
   
        stage('Build') {
            steps {
                // Assuming `mvn clean install` is the build command
                sh 'mvn clean install -DskipTests' 
            }
        }

        stage('Test') {
            steps {
                // Running tests
                sh 'mvn test'
            }
        }
        
        stage('Archive Artifact') {
            steps {
                // Archives the resulting .jar file
                archiveArtifacts artifacts: 'target/*.jar'
            }
        }
    }
    
    post {
        always {
            // Clean up workspace after the build is complete
            deleteDir()
        }
        success {
            echo 'Build successful!'
            // You can add notifications here, like Slack or email
        }
        failure {
            echo 'Build failed!'
            // You can add notifications here for failures
        }
    }
}
