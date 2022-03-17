#!/bin/bash

# Для успешной работы скрипта должен быть установлен Openstack Client

KEYFILE="$HOME/.ssh/id_rsa"

# Запрашиваем имя хоста
echo "Please enter hostname you want to get password for: "
read HOST_INPUT
export HOST=$HOST_INPUT

# Проверяем, что файл приватного ключа существует
if [ ! -f $KEYFILE ]; then
    echo "Ther is no private key, generating..."
    ssh-keygen -f $KEYFILE -m PEM -N ""
fi

# Проверяем, в каком формате приватный SSH-ключ
# Если это OpenSSH, а не RSA, предлагаем сменить формат
if [[ ! $(head -n 1 $KEYFILE) == "-----BEGIN RSA PRIVATE KEY-----" ]]; then
    echo "Private key not in RSA format, converting..."
    cp $KEYFILE $KEYFILE.bkp && ssh-keygen -f $KEYFILE -m PEM -p -q -N "" && echo "Private key successfully converted to RSA, backup is stored in $KEYFILE.bkp"
fi

# Временно меняем переменные окружения, настраивающие доступ к облаку, так, чтобы клиент nova мог работать
unset OS_DOMAIN_ID
export OS_USER_DOMAIN_NAME="users"

# С помощью клиента nova запрашивает с облачной платформы пароль от
echo "========================"
echo "Login: Admin"
echo "Password:" $(nova get-password $HOST $KEYFILE)

# Возвращаем переменные на место
unset OS_USER_DOMAIN_NAME
export OS_DOMAIN_ID="users"