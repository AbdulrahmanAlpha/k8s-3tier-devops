FROM jenkins/jenkins:lts
USER root
# install docker cli
RUN apt-get update && apt-get install -y docker.io awscli kubectl jq
# ensure jenkins user can use docker
RUN usermod -aG docker jenkins
USER jenkins
