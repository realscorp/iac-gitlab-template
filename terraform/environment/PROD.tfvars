# PROD
dns_zone = "domain.example.com."

# Блок переменных для представленных примеров
app_flavor = "Standard-4-8-80"
app_sg = ["i_default","o_default"]
app_root_vol_size = 100

db_flavor = "Standard-4-16-50"
db_sg = ["i_default","o_default"]
db_root_vol_size = 50
db_bases_vol_size = 300

i_int_example_ip_list= {
    "Office 1 subnet" = "10.0.0.0/16"
    "Office 2 subnet" = "10.1.0.0/16"
    "Office 3 subnet" = "10.2.0.0/16"
    "Service 1" = "10.4.0.10"
}