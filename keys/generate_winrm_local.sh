#!/bin/bash

# Завершить скрипт немедленно, если возникла ошибка
set -e

# Задаём вводные
USER_NAME="Admin"
FILE_NAME="winrm"
STOREPATH=${HOME}"/.winrm/"

# Генерируем атрибуты сертификата
UPN=$USER_NAME@localhost
SUBJECT="/CN=$USER_NAME"

# Задаём имена файлов, PEM - открытая часть сертификата, PFX - пакет закрытый+открытый, DER - открытая часть в формате .der
PFX_FILE=${STOREPATH}${FILE_NAME}.pfx
PEM_FILE=${PFX_FILE%.*}.pem
DER_FILE=${PFX_FILE%.*}.der
KEY_FILE=${PFX_FILE%.*}.key

# Проверяем, что в каталоге нет ранее сгенерированных файлов
{
if [ -f $KEY_FILE ]; then
    echo "WinRM key already exist! If you want to create new key, delete old first"
    echo $KEY_FILE
    exit 0
fi
}

echo $KEY_FILE

# Убеждаемся, что каталог существует
mkdir -p $STOREPATH

# Создаём файл с конфигурацией openssl и настраиваем openssl на его использование
EXT_CONF_FILE=`mktemp -t cloudbase-initXXXXXX.conf`
cat > $EXT_CONF_FILE << EOF
distinguished_name  = req_distinguished_name
[req_distinguished_name]
[v3_req_client]
extendedKeyUsage = clientAuth
subjectAltName = otherName:1.3.6.1.4.1.311.20.2.3;UTF8:$UPN
EOF
export OPENSSL_CONF=$EXT_CONF_FILE

# Генерируем сертификат, записываем открытую часть и ключ
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -out "$PEM_FILE" \
-outform PEM -keyout $KEY_FILE -subj "$SUBJECT" \
-extensions v3_req_client 2> /dev/null

# Убираем конфиг за собой
rm $EXT_CONF_FILE
unset OPENSSL_CONF

# Создаём пакет из открытой и закрытой части, устанавливаем пустой пароль. Если нужно задать пароль, убираем -password
openssl pkcs12 -export -in "$PEM_FILE" -inkey $KEY_FILE -out "$PFX_FILE" -password pass:""

# Конвертируем PEM в DER, чтобы мы могли использовать его в атрибуте metadata в Terraform
openssl x509 -inform pem -in "$PEM_FILE" -outform der -out "$DER_FILE"

# Выводим опечаток сертификата
THUMBPRINT=`openssl x509 -inform PEM -in "$PEM_FILE" -fingerprint -noout | \
sed -e 's/\://g' | sed -n 's/^.*=\(.*\)$/\1/p'`

echo "Certificate Subject: $(echo \"$SUBJECT\" | sed -e 's/\///g')"
echo "Certificate Thumbprint: $THUMBPRINT"
