@Library('shared-lib') _

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

        stage('Docker Build and Push') {

            steps {

                script {

                    dockerBuildPush(

                        imageName: env.IMAGE_NAME,
                        imageTag: env.IMAGE_TAG,
                        projectId: env.PROJECT_ID,
                        repoName: env.REPO_NAME

                    )
                }
            }
        }
    }
}
