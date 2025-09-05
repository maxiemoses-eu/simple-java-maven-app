pipeline {
    agent any
    tools {
        maven 'Maven 3.9'
    }
    stsges {
        stage ("build") {
            steps {
                script {
                    echo "building the application...
                    sh 'mvn clean package'
                }
            }
        }
    }
    stsges {
        stage ("test") {
            steps {
                script {
                    echo "tesing the application"
                    sh 'mvn clean package'
                }
            }
        }
    }
    stsges {
        stage ("deploy") {
            steps {
                script {
                    echo "tesing the application"
                }
            }
        }
    }
}
