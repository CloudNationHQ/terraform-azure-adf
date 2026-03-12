module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.27"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "vnet" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 9.0"

  naming = local.naming

  vnet = {
    name                = module.naming.virtual_network.name
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
    address_space       = ["10.0.0.0/16"]

    subnets = {
      ssis = {
        name             = module.naming.subnet.name
        address_prefixes = ["10.0.0.0/24"]
      }
    }
  }
}

module "adf" {
  source  = "cloudnationhq/adf/azure"
  version = "~> 1.0"

  instance = {
    name                = module.naming.data_factory.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name

    identity = {
      type = "SystemAssigned"
    }

    integration_runtimes = {
      azure = {
        azure-ir = {
          location    = module.rg.groups.demo.location
          description = "Auto-resolving Azure Integration Runtime"
        }
      }

      self_hosted = {
        self-hosted-ir = {
          description = "Self-hosted IR for on-premises data sources"
        }
      }

      azure_ssis = {
        ssis-ir = {
          location  = module.rg.groups.demo.location
          node_size = "Standard_D2_v3"

          vnet_integration = {
            vnet_id     = module.vnet.vnet.id
            subnet_name = module.vnet.subnets.ssis.name
          }

          catalog_info = {
            server_endpoint        = "tcp:myserver.database.windows.net,1433"
            administrator_login    = "ssisadmin"
            administrator_password = "MyP@ssw0rd!"
          }
        }
      }
    }
  }
}
