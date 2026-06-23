#!/bin/bash
# PUNTO D - Ansible
# Cornejo

cd "$HOME/UTN-FRA_SO_Examenes/202406/ansible/"

ansible-playbook -i inventory/hosts playbook.yml -b

echo "punto D listo"
