pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        }
    triggers {
        cron(env.BRANCH_NAME == 'main' ? 'H 0 * * *' : '')
        pollSCM('*/5 * * * *')
    }
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                echo 'No code to build :)'
            }
        }
        stage('Test') {
            steps {
                echo 'No test to run:)'
            }
        }
        stage('Pull webgoat docker Image') {

             steps {
                 echo 'pull webgoat 7 docker image'
                 bat 'scripts\\pull-webgoat7-image.cmd'
             }
        }
        stage('Run webgoat docker container') {
             steps {
                bat 'scripts\\spin-up-docker-container-local-windows.cmd'
             }
        }

        stage('Security Test') {
             steps {
                echo 'Run Zap security test'
                bat 'scripts\\zap-test-using-rest-api.cmd'

             }
        }

    }
	post {
         always {
             echo 'Post jobs started...'
         }
         success {
             echo 'Build successful!'
         }
         failure {
             echo 'Build failed!'
         }
         unstable {
             echo 'Something is unstable...'
         }
         changed {
            echo 'State changed...'
         }
     }
}
