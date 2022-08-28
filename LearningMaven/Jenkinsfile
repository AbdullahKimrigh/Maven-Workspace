pipeline {

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('Abdullah-Dockerhub')
		AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
  		AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
		ARTIFACT_NAME = 'Dockerrun.aws.json'
		AWS_S3_BUCKET = '2048-game-file'
		AWS_EB_APP_NAME = '2048-game'
        AWS_EB_ENVIRONMENT_NAME = '2048game-env'
        AWS_EB_APP_VERSION = "${BUILD_ID}"
	}

	stages {

        stage('Build') {

			steps {
				sh 'docker build -t abdullahkimrigh/2048-game:0.0.1 .'
			}
		}

        stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push abdullahkimrigh/2048-game:0.0.1'
			}
		}

        stage('Deploy') {
            steps {
                sh 'aws configure set region us-east-1'
                sh 'aws elasticbeanstalk create-application-version --application-name $AWS_EB_APP_NAME --version-label $AWS_EB_APP_VERSION --source-bundle S3Bucket=$AWS_S3_BUCKET,S3Key=$ARTIFACT_NAME'
                sh 'aws elasticbeanstalk update-environment --application-name $AWS_EB_APP_NAME --environment-name $AWS_EB_ENVIRONMENT_NAME --version-label $AWS_EB_APP_VERSION'
            }
	}
    }
	post {
		always {
			sh 'docker logout'
		}
	}

}