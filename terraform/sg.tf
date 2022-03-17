# Больше примеров создания групп фаервола можно увидеть в ридми к модулю
# https://github.com/realscorp/tf-openstack-vkcs-secgroup

# module "i_int_example" {
#     source = "git@github.com:realscorp/tf-openstack-vkcs-secgroup.git"
#     name = "i_int_example"
#     description = "Group to access some service"
#     rules = [{
#                 direction = "ingress"
#                 protocol = "tcp"
#                 ports = ["1234", "900-1000"]
#                 remote_ips = var.i_int_example_ip_list
#                 }
#             ]
# }

