# Переменные для локального запуска кода на исполнение в проекте-песочнице

# PLAYGROUND
dns_zone = "test.example.com."

# Блок переменных для представленных примеров
app_flavor = "Basic-1-4-50"
app_sg = ["i_default","o_default"]
app_root_vol_size = 50

db_flavor = "Standard-2-2"
db_sg = ["i_default","o_default"]
db_root_vol_size = 5
db_bases_vol_size = 15

i_int_example_ip_list= {
    "Internal" = "10.0.0.0/8"
}