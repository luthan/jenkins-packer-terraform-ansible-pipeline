This setup builds a jenkins server and a web server.  when web page changes occur, jenkins will poll the scm
and build a new ami which will then be deployed by terraform


Instructions:

First need to create two AMIs, in "first_steps" directory:

packer build jenkins-server.json

packer build web-server.json

initialize terraform and build jenkins server and web server - in terraform directory

make sure you have the proper bucket setup in s3

terraform init

terraform plan

terraform apply



