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

                    env.IMAGE_TAG =
                        "build-${BUILD_NUMBER}-${SHORT_COMMIT}"
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

        stage('Security Scan') {

            steps {

                sh """

                trivy image \
                --exit-code 1 \
                --severity CRITICAL,HIGH \
                ${IMAGE_NAME}:${IMAGE_TAG}

                """
            }
        }

        stage('Docker Push') {

            steps {

                sh """

                docker tag \
                ${IMAGE_NAME}:${IMAGE_TAG} \
                us-central1-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:${IMAGE_TAG}

                docker push \
                us-central1-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:${IMAGE_TAG}

                """
            }
        }

        stage('Deploy to GKE') {

            when {

                branch 'dev'
            }

            steps {

                sh """

                sed -i 's|IMAGE_PLACEHOLDER|us-central1-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:${IMAGE_TAG}|g' k8s/deployment.yaml

                kubectl apply -f k8s/

                """
            }
        }
    }
}
