pipeline {
    agent any

    environment {
        // setting this for packer, it will use it to get current dir context, wasn't sure how else to do it
        WORKINGDIR = pwd()
    }

    stages {
        stage('Build') {
            steps {
                sh 'ansible-galaxy install geerlingguy.apache'
                dir ('packer'){
                    sh 'packer build web-server.json'
                }
            }
        }

        stage('Deploy') {
            steps {
                dir ('terraform'){
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
