#!/bin/bash
CREDENTIALS_FILE=/vagrant/credentials.csv
sudo yum install -y dos2unix 
dos2unix $CREDENTIALS_FILE
echo "export AWS_ACCESS_KEY_ID=$(tail -1 $CREDENTIALS_FILE | cut -d ',' -f1)" | tee -a /home/vagrant/.bash_profile
echo "export AWS_SECRET_ACCESS_KEY=$(tail -1 $CREDENTIALS_FILE | cut -d ',' -f2)" | tee -a /home/vagrant/.bash_profile
