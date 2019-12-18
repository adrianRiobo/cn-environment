#!/bin/bash

# Install docker
if [ ! -f "/usr/bin/docker" ]
then
  sudo yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2
  sudo yum-config-manager \
      --add-repo \
      https://download.docker.com/linux/centos/docker-ce.repo

  sudo yum install -y docker-ce docker-ce-cli containerd.io
  sudo systemctl start docker
  sudo systemctl enable docker
  #As this bootstrap.sh will be executed as root
  sudo usermod -aG docker vagrant
fi

# Install kind
if [ ! -f "/usr/local/bin/kind" ]
then
  curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.6.1/kind-$(uname)-amd64
  chmod +x ./kind
  sudo mv ./kind /usr/local/bin
fi

# Install kubectl
KUBECTL_VERSION=1.16.0 
KUBECTL_DOWNLOAD_URL=https://storage.googleapis.com/kubernetes-release/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl
if [ ! -f "/usr/local/bin/kubectl" ]
then
  echo "Installing $KUBECTL_DOWNLOAD_URL"
  CURRENT_PATH=$PWD
  cd /tmp 
  curl -LO $KUBECTL_DOWNLOAD_URL
  chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
  cd $CURRENT_PATH
fi

# Install awscli
if [ ! -f "/usr/local/bin/aws" ]
then
  sudo yum install -y unzip
  curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
  unzip awscli-bundle.zip
  sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
  rm -r awscli-bundle
  rm awscli-bundle.zip
fi

# Configure AWS Credentials configuration on every init
sudo cp /vagrant/configure_credentials.service /etc/systemd/system/configure_credentials.service
sudo systemctl enable configure_credentials
sudo systemctl start configure_credentials
sudo chmod +x /vagrant/configure_credentials.sh
