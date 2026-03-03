# Complete

This example illustrates a comprehensive Azure Data Factory setup with linked services, datasets, and a data copy pipeline.

## Usage

```hcl
module "adf" {
  source  = "cloudnationhq/adf/azure"
  version = "~> 0.1"

  instance = {
    name                = "adf-complete-demo"
    location            = "westeurope"
    resource_group_name = "rg-complete-demo"

    identity = {
      type = "SystemAssigned"
    }

    linked_services = {
      azure_blob_storage = {
        blob1 = {
          name                 = "LinkedService_BlobStorage"
          storage_account_name = "mystorageaccount"
          use_managed_identity = true
        }
      }

      azure_sql_database = {
        sql1 = {
          name             = "LinkedService_AzureSQL"
          connection_string = "Server=tcp:myserver.database.windows.net,1433;Initial Catalog=mydb;Persist Security Info=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
        }
      }
    }

    datasets = {
      azure_blob = {
        blob_input = {
          name                = "BlobDataset_Input"
          linked_service_name = "LinkedService_BlobStorage"
          path                = "input"
          filename            = "data.csv"
        }
      }

      azure_sql_table = {
        sql_table = {
          name                = "SqlDataset_Target"
          linked_service_name = "LinkedService_AzureSQL"
          table_name          = "dbo.TargetTable"
        }
      }
    }

    pipelines = {
      copy_pipeline = {
        name        = "CopyDataPipeline"
        description = "Copy data from blob to SQL"
        activities = [
          {
            name = "CopyData"
            type = "Copy"
          }
        ]
      }
    }
  }
}
```