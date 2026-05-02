pipeline {

    agent any

    environment {

        PROJECT_ID = "poc-01-488406"
        REPO_NAME = "my-docker-repo"
        IMAGE_NAME = "myapp"

    }

    stages {

        stage('Set Dynamic Tag') {

            steps {

                script {

                    SHORT_COMMIT = sh(
                        script: "git rev-parse --short HEAD",
                        returnStdout: true
                    ).trim()

                    IMAGE_TAG = "build-${BUILD_NUMBER}-${SHORT_COMMIT}"

                    env.IMAGE_TAG = IMAGE_TAG

                }
            }
        }

        stage('Parallel Validation') {

            parallel {

                stage('Lint Check') {

                    steps {

                        sh '''
                        echo "Running lint checks..."
                        sleep 10
                        echo "Lint completed"
                        '''
                    }
                }

                stage('Unit Tests') {

                    steps {

                        sh '''
                        echo "Running unit tests..."
                        sleep 15
                        echo "Tests completed"
                        '''
                    }
                }

                stage('Security Scan') {

                    steps {

                        sh '''
                        echo "Running security scan..."
                        sleep 12
                        echo "Security scan completed"
                        '''
                    }
                }
            }
        }

        stage('Build Docker Image') {

            steps {

                sh """
                docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                """
            }
        }

        stage('Push Docker Image') {

            steps {

                sh """
                docker tag ${IMAGE_NAME}:${IMAGE_TAG} \
                us-central1-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:${IMAGE_TAG}

                docker push \
                us-central1-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:${IMAGE_TAG}
                """
            }
        }
    }
}
