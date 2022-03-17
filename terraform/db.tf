# Больше примеров развёртывания инстансов можно увидеть в ридми к модулю
# https://github.com/realscorp/tf-openstack-vkcs-vm

# # Linux-инстанс с PostgreSQL
# module "v-db-example" {
#     source          = "git@github.com:realscorp/tf-openstack-vkcs-vm.git"
#     name            = "v-db-example"
#     flavor          = var.db_flavor
#     image           = "Ubuntu-20.04.1-202008"
#     ssh_key_name    = openstack_compute_keypair_v2.terraform.name # Не изменять
#     metadata        = {
#         os = "linux"
#         os_ver = "ubuntu20"
#         app = "postgresql"
#         service = "EXAMPLE"
#         }
#     ports = [
#         {
#             network         = "network-1"
#             subnet          = ""
#             ip_address      = ""
#             dns_record      = true
#             dns_zone        = var.dns_zone # Не изменять
#             security_groups = var.db_sg
#             security_groups_ids = []
#         }
#     ]
#     volumes = {
#         root = {
#             type            = "ceph-ssd"
#             size            = var.db_root_vol_size
#         }
#         bases = {
#             type            = "ceph-ssd"
#             size            = var.db_bases_vol_size
#         }
#     }
# }
