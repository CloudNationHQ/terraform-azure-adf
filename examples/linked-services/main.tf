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

module "kv" {
  source  = "cloudnationhq/kv/azure"
  version = "~> 4.0"

  vault = {
    name                = module.naming.key_vault.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
  }
}

module "storage" {
  source  = "cloudnationhq/sa/azure"
  version = "~> 4.0"

  storage = {
    name                              = module.naming.storage_account.name_unique
    location                          = module.rg.groups.demo.location
    resource_group_name               = module.rg.groups.demo.name
    infrastructure_encryption_enabled = true
    is_hns_enabled                    = true
  }
}

module "data_factory" {
  source  = "cloudnationhq/adf/azure"
  version = "~> 1.0"

  instance = {
    name                = module.naming.data_factory.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name

    identity = {
      type = "SystemAssigned"
    }

    linked_services = {
      key_vault = {
        key_vault_main = {
          key_vault_id = module.kv.vault.id
        }
      }
      azure_blob_storage = {
        blob_storage_main = {
          service_endpoint     = module.storage.account.primary_blob_endpoint
          use_managed_identity = true
        }
      }
      data_lake_storage_gen2 = {
        adls_gen2_main = {
          url                  = module.storage.account.primary_dfs_endpoint
          use_managed_identity = true
        }
      }
    }
  }
}