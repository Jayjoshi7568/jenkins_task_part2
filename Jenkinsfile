pipeline {
    agent any
    tools {
        Docker 'docker'
    }
    environment {
        IMAGE_NAME = "jay7568/react_app:${env.BUILD_NUMBER}"
    }
    stages {
        stage('Building the app') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t ${IMAGE_NAME} ."
                }

                script {
                    // Use Docker credentials to push the image
                    withCredentials([usernamePassword(credentialsId: 'my-docker-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                        echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin
                        docker push ${IMAGE_NAME}
                        """
                    }
                }

                script {
                    def compose = readFile(file: 'docker-compose-template.yml')
                    def composeConfig = compose.replace('${IMAGE_NAME}', "${IMAGE_NAME}")
                    writeFile file: './docker-compose.yml', text: composeConfig
                }

                script {
                    // sh "docker-compose up -d"
                    sh "cat docker-compose.yml"
                }
            }
        }
    }
}

