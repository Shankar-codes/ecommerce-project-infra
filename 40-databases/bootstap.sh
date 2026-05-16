#/bin/bash
dnf install ansible -y
ansible-pull -u https://github.com/Shankar-codes/ansible-roles-terraform.git -e component=mongodb main.yaml