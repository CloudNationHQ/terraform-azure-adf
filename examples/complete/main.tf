module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "complete"]
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

module "storage" {
  source  = "cloudnationhq/sa/azure"
  version = "~> 3.0"

  storage = {
    name           = module.naming.storage_account.name_unique
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name
  }
}

module "adf" {
  source  = "cloudnationhq/adf/azure"
  version = "~> 0.1"

  instance = {
    name                = module.naming.data_factory.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name

    identity = {
      type = "SystemAssigned"
    }

    linked_services = {
      azure_blob_storage = {
        blob1 = {
          name                 = "LinkedService_BlobStorage"
          storage_account_name = module.storage.account.name
          use_managed_identity = true
        }
      }

      azure_sql_database = {
        sql1 = {
          name              = "LinkedService_AzureSQL"
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
          folder_path         = "datasets"
        }

        blob_output = {
          name                = "BlobDataset_Output"
          linked_service_name = "LinkedService_BlobStorage"
          path                = "output"
          filename            = "processed.csv"
          folder_path         = "datasets"
        }
      }

      delimited_text = {
        csv_data = {
          name                = "DelimitedText_Source"
          linked_service_name = "LinkedService_BlobStorage"
          path                = "source"
          filename            = "*.csv"
          column_delimiter    = ","
          row_delimiter       = "\n"
          first_row_as_header = true
          folder_path         = "datasets"
        }
      }

      azure_sql_table = {
        sql_table = {
          name                = "SqlDataset_Target"
          linked_service_name = "LinkedService_AzureSQL"
          table_name          = "dbo.TargetTable"
          folder_path         = "datasets"
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
            inputs = [{
              referenceName = "BlobDataset_Input"
              type          = "DatasetReference"
              parameters    = {}
            }]
            outputs = [{
              referenceName = "SqlDataset_Target"
              type          = "DatasetReference"
              parameters    = {}
            }]
            typeProperties = {
              source = {
                type = "BlobSource"
              }
              sink = {
                type = "SqlSink"
              }
            }
          }
        ]
        folder_path = "pipelines"
      }
    }
  }
}
