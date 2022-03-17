#!/usr/bin/env bash

######
# Блок настройки Openstack для подключения к облаку VKCS
##################

# MCS-специфичные настройки
export OS_AUTH_URL="https://infra.mail.ru:35357/v3/"
export OS_PROJECT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" # ID проекта-песочницы
export OS_REGION_NAME="RegionOne"
export OS_USER_DOMAIN_NAME="users"
 
# Убираем старые переменные
unset OS_TENANT_ID
unset OS_TENANT_NAME
unset OS_PROJECT_NAME
unset OS_PROJECT_DOMAIN_ID

# Если логин и пароль ещё не заданы в переменных окружения, запрашиваем их ввод у пользователя
if [[ -z $OS_USERNAME ]] || [[ -z $OS_PASSWORD ]]; then
	 
	echo "Please enter your OpenStack Username for project $OS_PROJECT_ID: "
	read -sr OS_USERNAME_INPUT
	export OS_USERNAME=$OS_USERNAME_INPUT

	echo "Please enter your OpenStack Password for project $OS_PROJECT_ID as user $OS_USERNAME: "
	read -sr OS_PASSWORD_INPUT
	export OS_PASSWORD=$OS_PASSWORD_INPUT

fi  


######
# Блок DNS-провайдера в части аутентификации
##################
# Задаём положение файла с конфигурацией kerberos для правильной работы механизма GSS-TSIG при работе с Microsoft DNS Server
export KRB5_CONFIG=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )/terraform/config/krb5_config

