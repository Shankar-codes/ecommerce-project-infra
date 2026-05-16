#/bin/bash
dnf install ansible -y
ansible-pull -U https://github.com/Shankar-codes/ansible-roles-terraform.git -e component=mongodb main.yaml