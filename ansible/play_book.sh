#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Uso: $0 <ultimo_octet_IP> <nome_cartella_playbook>"
  exit 1
fi

IP="10.0.46.$1"
PLAYBOOK_DIR="$2"
PLAYBOOK_FILE="$PLAYBOOK_DIR/$PLAYBOOK_DIR.ansible.yml"

ansible-playbook -u root --key-file ~/.ssh/puccia.key -i "$IP," "$PLAYBOOK_FILE"
