#######################
# Переменные для работы провайдера dns, по-умолчанию заданы значения для зоны test.example.com
#######################
variable "dns_username" {
    description = "Default value gives access to test.example.com. zone"
    type = string
    default = "service-account"
}
variable "dns_password" {
    description = "Default value gives access to test.example.com. zone"
    type = string
    default = "xxxxxxxxxxxxxxxxxxx"
}
variable "dns_zone" {
    description = "Default zone to create DNS records"
    type = string
}
#######################
# Блок переменных для предоставленных примеров
# Сами значения для работы в песочнице задаются в playground.auto.tfvars,
# значения для боевых окружений - в каталоге environment/
#######################

# APP
########
variable "app_flavor" {
    description = "APP Server flavor"
    type = string
}
variable "app_sg" {
    description = "APP server SGs"
    type = list(string)
}
variable "app_root_vol_size" {
    description = "APP root volume size"
    type = number
}

# DB
########
variable "db_flavor" {
    description = "DB Server flavor"
    type = string
}
variable "db_sg" {
    description = "DB server SGs"
    type = list(string)
}
variable "db_root_vol_size" {
    description = "DB root volume size"
    type = number
}
variable "db_bases_vol_size" {
    description = "DB bases volume size"
    type = number
}

# Security Groups
########
variable "i_int_example_ip_list" {
    description = "i_int_app_example IP list"
    type = map(string)
}