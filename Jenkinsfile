pipeline {
    agent any
    environment {
        IMAGE_NAME = "jay7568/react_app:${env.BUILD_NUMBER}"
    }
    stages {
        stage('Building the app') {
            steps {
                // script {
                //     // Build Docker image
                //     sh "docker build -t ${IMAGE_NAME} ."
                // }

                // script {
                //     "docker push ${IMAGE_NAME}"
                // }

                script {
                    def compose = readFile(file: 'docker-compose-template.yml')
                    def composeConfig = compose.replace('${IMAGE_NAME}', ${IMAGE_NAME})
                    writeFile file: './docker-compose.yml', text: compose
                }

                script {
                    // sh "docker-compose up -d"
                    sh "cat docker-compose.yml"
                }
            }
        }
    }
}
