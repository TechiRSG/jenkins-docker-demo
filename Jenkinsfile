pipeline {

    agent any

    environment {

        PROJECT_ID = "poc-01-488406"
        REPO_NAME = "my-docker-repo"
        IMAGE_NAME = "myapp"

    }

    stages {

        stage('Branch Info') {

            steps {

                echo "Branch Name: ${env.BRANCH_NAME}"

            }
        }

        stage('Build Docker Image') {

            steps {

                sh '''
                docker build -t myapp:${BUILD_NUMBER} .
                '''
            }
        }

        stage('Feature Branch Build Only') {

            when {

                expression {
                    env.BRANCH_NAME.startsWith("feature/")
                }
            }

            steps {

                echo "Feature branch detected"

            }
        }

        stage('Deploy to Dev') {

            when {

                branch 'dev'
            }

            steps {

                echo "Deploying to DEV environment"

            }
        }

        stage('Deploy to Production') {

            when {

                branch 'main'
            }

            steps {

                echo "Deploying to PRODUCTION"

            }
        }
    }
}
