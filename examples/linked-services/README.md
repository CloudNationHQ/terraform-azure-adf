# Linked Services

This example shows how to configure linked services in Azure Data Factory.

## Usage

```hcl
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
        ls_key_vault_main = {
          name         = "ls_key_vault_main"
          key_vault_id = module.kv.vault.id
        }
      }
      azure_blob_storage = {
        ls_blob_storage_main = {
          name                 = "ls_blob_storage_main"
          service_endpoint     = module.storage.account.primary_blob_endpoint
          use_managed_identity = true
        }
      }
      data_lake_storage_gen2 = {
        ls_adls_gen2_main = {
          name                 = "ls_adls_gen2_main"
          url                  = module.storage.account.primary_dfs_endpoint
          use_managed_identity = true
        }
      }
    }
  }
}
```

## Resources

The example includes the following resources:

- Resource Group
- Key Vault
- Storage Account with hierarchical namespace (Data Lake Storage Gen2)
- Data Factory with linked services