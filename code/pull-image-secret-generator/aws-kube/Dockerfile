FROM  debian:stable-slim

RUN apt-get update && \
apt-get install -y curl unzip apt-transport-https gnupg2 && \
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
unzip awscliv2.zip && \
./aws/install && \
apt-get update && \
apt-get install -y kubectl && \
useradd -m aws-kube

USER aws-kube

WORKDIR /home/aws-kube