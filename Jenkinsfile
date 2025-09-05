pipeline {
    agent any
    maven 9
   
       pipeline {
    agent any

    stages {
        stage('build') {
            steps {
                scritp {
                  echo 'building the application...'
                  sh 'mvn clean package'
                }
            }
        }
        stage('test') {
            steps {
                script {
                  echo 'testing the application...'
                  sh 'mvn clean package'
                }
            }
        }
        stage('deploy') {
            steps {
                script {
                  echo 'deploying the application...'
                  }
            }
        }
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
