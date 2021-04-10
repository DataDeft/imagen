
# Ansible repo for configuring AWS nodes for better performance and with extra disk

Only CentOS / RedHat / Amazon Linux is supported.


- ansible-playbook -i inventories/aws.hosts playbooks/ssh-keyscan.yml
- ansible-playbook -i inventories/aws.hosts playbooks/os.yml
- ansible-playbook -i inventories/aws.hosts playbooks/postfix.yml
- ansible-playbook -i inventories/aws.hosts playbooks/disk.yml

