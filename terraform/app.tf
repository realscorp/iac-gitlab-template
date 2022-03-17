# Больше примеров развёртывания инстансов можно увидеть в ридми к модулю
# https://github.com/realscorp/tf-openstack-vkcs-vm

# # Windows-инстанс сервера приложения
# module "m-app-example" {
#     source          = "git@github.com:realscorp/tf-openstack-vkcs-vm.git"
#     name            = "m-app-example"
#     flavor          = var.app_flavor
#     image           = "Windows-Server-2019Std-en.202105"
#     ssh_key_name    = openstack_compute_keypair_v2.terraform.name # Не изменять
#     winrm_cert_path = local.winrm  # Не изменять
#     metadata        = {
#         os = "windows"
#         os_ver = "2019"
#         app = "EXAMPLE"
#         }
#     ports = [
#         {
#             network         = "network-1"
#             subnet          = ""
#             ip_address      = ""
#             dns_record      = true
#             dns_zone        = var.dns_zone # Не изменять
#             security_groups = var.app_sg
#             security_groups_ids = [module.i_int_example.id]
#         }
#     ]
#     volumes = {
#         root = {
#             type            = "ceph-ssd"
#             size            = var.app_root_vol_size
#         }
#     }
# }
