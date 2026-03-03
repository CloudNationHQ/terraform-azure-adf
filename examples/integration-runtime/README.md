# Integration Runtime

This example demonstrates various Azure Data Factory integration runtime configurations including Azure IR, Self-hosted IR, and Azure-SSIS IR with SQL Server catalog.

## Usage

```hcl
module "adf" {
  source  = "cloudnationhq/adf/azure"
  version = "~> 0.1"

  instance = {
    name                = "adf-ir-demo"
    location            = "westeurope"
    resource_group_name = "rg-ir-demo"

    identity = {
      type = "SystemAssigned"
    }

    integration_runtimes = {
      azure = {
        azure_ir = {
          name     = "AzureIntegrationRuntime"
          location = "westeurope"
        }
      }

      self_hosted = {
        self_hosted_ir = {
          name = "SelfHostedIntegrationRuntime"
        }
      }

      azure_ssis = {
        ssis_ir = {
          name      = "SSISIntegrationRuntime"
          location  = "westeurope"
          node_size = "Standard_D2_v3"

          vnet_integration = {
            vnet_id     = "/subscriptions/.../Microsoft.Network/virtualNetworks/vnet-demo"
            subnet_name = "ssis-subnet"
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
```

## Notes

The Azure-SSIS Integration Runtime example includes a SQL Server catalog configuration. When deploying, ensure:
- The SQL Server is accessible from the SSIS subnet
- The administrator credentials are valid and securely managed
- Virtual network integration is configured for on-premises connectivity
