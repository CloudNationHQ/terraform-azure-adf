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

module "storage" {
  source  = "cloudnationhq/sa/azure"
  version = "~> 4.0"

  storage = {
    name                = module.naming.storage_account.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
  }
}

module "adf" {
  # source  = "cloudnationhq/adf/azure"
  # version = "~> 1.0"
  source = "../../"

  naming = local.naming

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
          linked_service_name = "LinkedService_BlobStorage"
          service_endpoint     = module.storage.account.primary_blob_endpoint
          use_managed_identity = true
        }
      }

      sql_server = {
        sql1 = {
          linked_service_name = "LinkedService_SqlServer"
          connection_string = "Server=tcp:myserver.database.windows.net,1433;Initial Catalog=mydb;Persist Security Info=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
        }
      }
    }

    datasets = {
      azure_blob = {
        blob_input = {
          linked_service_name = "LinkedService_BlobStorage"
          path                = "input"
          filename            = "data.csv"
          folder              = "datasets"
        }

        blob_output = {
          linked_service_name = "LinkedService_BlobStorage"
          path                = "output"
          filename            = "processed.csv"
          folder              = "datasets"
        }
      }

      delimited_text = {
        csv_data = {
          linked_service_name = "LinkedService_BlobStorage"
          column_delimiter    = ","
          row_delimiter       = "\n"
          first_row_as_header = true
          folder              = "datasets"

          azure_blob_storage_location = {
            container = "source"
            path      = "csv"
            filename  = "*.csv"
          }
        }
      }

      sql_server_table = {
        sql_table = {
          linked_service_name = "LinkedService_SqlServer"
          table_name          = "dbo.TargetTable"
          folder              = "datasets"
        }
      }
    }

    pipelines = {
      copy_pipeline = {
        description = "Copy data from blob to SQL"
        folder      = "pipelines"
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
      }
    }
  }
}
