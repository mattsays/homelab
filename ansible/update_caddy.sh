#!/bin/bash
ansible-playbook -u root --key-file ~/.ssh/puccia.key -i '10.0.46.121,' caddy/update.ansible.yml