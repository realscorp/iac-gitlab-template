terraform {
    required_providers {
        openstack = {
        source = "terraform-provider-openstack/openstack"
        version = "1.33.0"
        }
        mcs = {
            source = "MailRuCloudSolutions/mcs"
            version = "0.6.1"
        }
    }
}

# Провайдер полностью настраивается через переменные окружения OS_
provider "mcs" {
}

# Провайдер полностью настраивается через переменные окружения OS_
provider "openstack" {
}

provider "dns" {
  update {
    server = "dc1.domain.example.com"
    gssapi {
        realm    = "DOMAIN.EXAMPLE.COM"
        username = var.dns_username
        password   = var.dns_password
    }
  }
}