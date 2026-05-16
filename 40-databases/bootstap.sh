#/bin/bash
component=$1
dnf install ansible -y
pip3 install boto3 botocore
ansible-pull -U https://github.com/Shankar-codes/ansible-roles-terraform.git -e component=$component main.yaml