#!/bin/bash

# Define file path variables
ANS_ROOT=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )/ansible
VAULT_FILE=$ANS_ROOT/vault-vars.yml
PASS_FILE=$ANS_ROOT/vault-pass.txt
CONFIG_FILE=$ANS_ROOT/ansible.cfg

# If vault file exists warn user and stop script
if [ -f $VAULT_FILE ]; then
    printf "\e[31mVault file already exist! If you want to create new Vault, delete old first\e[0m\n"
    printf '\e[31m\e[1m'$VAULT_FILE'\e[21m\e[0m\n'
    exit 0
fi

# Generate some random password and printing it so user can copy-paste it to CI/CD variables
PASSWORD=$(echo $RANDOM | md5sum | head -c 32) && printf 'Password generated: \e[95m\e[1m'$PASSWORD'\e[21m\e[0m, now add it to CI/CD var \e[1mANSIBLE_VAULT_PASS\e[0m\n'
echo $PASSWORD > $PASS_FILE && printf 'Password file created: \e[1m'$PASS_FILE'\e[0m\n'

# Create empty var file and encrypt it
touch $VAULT_FILE
ansible-vault encrypt --vault-password-file=$PASS_FILE $VAULT_FILE > /dev/null && printf 'Vault protected file created: \e[1m'$VAULT_FILE'\e[0m\n'

# Create ansible.cfg, where we set path to vault password file for local development convinience
cat << EOF > $CONFIG_FILE
[defaults]
vault_password_file = ./vault-pass.txt
EOF

# Print some user manual
printf 'Use \e[1mansible-vault edit vault-vars.yml\e[0m command to edit file\n'
