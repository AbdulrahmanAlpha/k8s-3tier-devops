#!/usr/bin/env bash
set -e
# install docker
amazon-linux-extras install -y docker
service docker start
usermod -a -G docker ec2-user
# pull jenkins image & run (use official jenkins + docker CLI)
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 \
  -v /var/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins/jenkins:lts
# install awscli & kubectl for convenience
yum install -y python3
pip3 install awscli
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
mv kubectl /usr/local/bin && chmod +x /usr/local/bin/kubectl
# optional: install jq
yum install -y jq
