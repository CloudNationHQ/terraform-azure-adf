# Azure Data Factory

This terraform module simplifies the creation and management of azure data factory resources, providing customizable options for linked services, datasets, pipelines, and integration runtimes, all managed through code.

## Features

Supports over twenty linked service types including azure blob storage, sql server, databricks, snowflake, sftp, and more.

Offers a wide range of dataset types such as parquet, json, delimited text, binary, sql server table, and azure blob.

Provides data flow and flowlet data flow capabilities for complex data transformations.

Includes three integration runtime types: azure, azure ssis, and self-hosted.

Enables pipeline definitions with json-encoded activities for flexible orchestration.

Supports multiple trigger types including blob event, schedule, tumbling window, and custom event.

Offers managed private endpoint support for secure connectivity.

Provides customer managed key encryption for enhanced data protection.

Supports credentials through service principal and user managed identity.

Integrates with github and azure devops for git-based source control.

Utilization of terratest for robust validation.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.0)

## Resources

The following resources are used by this module:

- [azurerm_data_factory.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory) (resource)
- [azurerm_data_factory_credential_service_principal.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_credential_service_principal) (resource)
- [azurerm_data_factory_credential_user_managed_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_credential_user_managed_identity) (resource)
- [azurerm_data_factory_custom_dataset.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_custom_dataset) (resource)
- [azurerm_data_factory_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_customer_managed_key) (resource)
- [azurerm_data_factory_data_flow.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_data_flow) (resource)
- [azurerm_data_factory_dataset_azure_blob.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_azure_blob) (resource)
- [azurerm_data_factory_dataset_azure_sql_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_azure_sql_table) (resource)
- [azurerm_data_factory_dataset_binary.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_binary) (resource)
- [azurerm_data_factory_dataset_cosmosdb_sqlapi.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_cosmosdb_sqlapi) (resource)
- [azurerm_data_factory_dataset_delimited_text.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_delimited_text) (resource)
- [azurerm_data_factory_dataset_http.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_http) (resource)
- [azurerm_data_factory_dataset_json.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_json) (resource)
- [azurerm_data_factory_dataset_mysql.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_mysql) (resource)
- [azurerm_data_factory_dataset_parquet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_parquet) (resource)
- [azurerm_data_factory_dataset_postgresql.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_postgresql) (resource)
- [azurerm_data_factory_dataset_snowflake.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_snowflake) (resource)
- [azurerm_data_factory_dataset_sql_server_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_sql_server_table) (resource)
- [azurerm_data_factory_flowlet_data_flow.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_flowlet_data_flow) (resource)
- [azurerm_data_factory_integration_runtime_azure.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_integration_runtime_azure) (resource)
- [azurerm_data_factory_integration_runtime_azure_ssis.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_integration_runtime_azure_ssis) (resource)
- [azurerm_data_factory_integration_runtime_self_hosted.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_integration_runtime_self_hosted) (resource)
- [azurerm_data_factory_linked_custom_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_custom_service) (resource)
- [azurerm_data_factory_linked_service_azure_blob_storage.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_azure_blob_storage) (resource)
- [azurerm_data_factory_linked_service_azure_databricks.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_azure_databricks) (resource)
- [azurerm_data_factory_linked_service_azure_file_storage.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_azure_file_storage) (resource)
- [azurerm_data_factory_linked_service_azure_function.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_azure_function) (resource)
- [azurerm_data_factory_linked_service_azure_search.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_azure_search) (resource)
- [azurerm_data_factory_linked_service_azure_sql_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_azure_sql_database) (resource)
- [azurerm_data_factory_linked_service_azure_table_storage.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_azure_table_storage) (resource)
- [azurerm_data_factory_linked_service_cosmosdb.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_cosmosdb) (resource)
- [azurerm_data_factory_linked_service_cosmosdb_mongoapi.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_cosmosdb_mongoapi) (resource)
- [azurerm_data_factory_linked_service_data_lake_storage_gen2.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_data_lake_storage_gen2) (resource)
- [azurerm_data_factory_linked_service_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_key_vault) (resource)
- [azurerm_data_factory_linked_service_kusto.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_kusto) (resource)
- [azurerm_data_factory_linked_service_mysql.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_mysql) (resource)
- [azurerm_data_factory_linked_service_odata.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_odata) (resource)
- [azurerm_data_factory_linked_service_odbc.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_odbc) (resource)
- [azurerm_data_factory_linked_service_postgresql.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_postgresql) (resource)
- [azurerm_data_factory_linked_service_sftp.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_sftp) (resource)
- [azurerm_data_factory_linked_service_snowflake.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_snowflake) (resource)
- [azurerm_data_factory_linked_service_sql_managed_instance.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_sql_managed_instance) (resource)
- [azurerm_data_factory_linked_service_sql_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_sql_server) (resource)
- [azurerm_data_factory_linked_service_synapse.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_synapse) (resource)
- [azurerm_data_factory_linked_service_web.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_web) (resource)
- [azurerm_data_factory_managed_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_managed_private_endpoint) (resource)
- [azurerm_data_factory_pipeline.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) (resource)
- [azurerm_data_factory_trigger_blob_event.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_blob_event) (resource)
- [azurerm_data_factory_trigger_custom_event.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_custom_event) (resource)
- [azurerm_data_factory_trigger_schedule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) (resource)
- [azurerm_data_factory_trigger_tumbling_window.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_tumbling_window) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_instance"></a> [instance](#input\_instance)

Description: describes data factory configuration

Type:

```hcl
object({
    name                             = string
    location                         = optional(string)
    resource_group_name              = optional(string)
    managed_virtual_network_enabled  = optional(bool, false)
    public_network_enabled           = optional(bool, true)
    purview_id                       = optional(string)
    customer_managed_key_id          = optional(string)
    customer_managed_key_identity_id = optional(string)
    tags                             = optional(map(string))
    global_parameters = optional(list(object({
      name  = string
      type  = string
      value = any
    })), [])
    identity = optional(object({
      type         = optional(string, "SystemAssigned")
      identity_ids = optional(list(string))
    }))
    vsts_configuration = optional(object({
      account_name       = string
      branch_name        = string
      project_name       = string
      repository_name    = string
      root_folder        = string
      tenant_id          = optional(string)
      publishing_enabled = optional(bool)
    }))
    github_configuration = optional(object({
      account_name       = string
      branch_name        = string
      git_url            = string
      repository_name    = string
      root_folder        = string
      publishing_enabled = optional(bool)
    }))
    credentials = optional(object({
      service_principal = optional(map(object({
        name                 = optional(string)
        service_principal_id = string
        tenant_id            = string
        description          = optional(string)
        annotations          = optional(list(string))
        service_principal_key = optional(object({
          linked_service_name = string
          secret_name         = string
          secret_version      = optional(string)
        }))
      })), {})
      user_managed_identity = optional(map(object({
        name        = optional(string)
        identity_id = string
        description = optional(string)
        annotations = optional(list(string))
      })), {})
    }), {})
    linked_services = optional(object({
      azure_blob_storage = optional(map(object({
        name                     = optional(string)
        use_managed_identity     = optional(bool)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
        connection_string        = optional(string)
        sas_uri                  = optional(string)
        service_endpoint         = optional(string)
        service_principal_id     = optional(string)
        service_principal_key    = optional(string)
        storage_kind             = optional(string)
        tenant_id                = optional(string)
        sas_token_linked_key_vault_key = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
      })), {})
      azure_sql_database = optional(map(object({
        name                     = optional(string)
        connection_string        = string
        use_managed_identity     = optional(bool)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
        service_principal_id     = optional(string)
        service_principal_key    = optional(string)
        tenant_id                = optional(string)
        credential_name          = optional(string)
        key_vault_password = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
        key_vault_connection_string = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
      })), {})
      azure_table_storage = optional(map(object({
        name                     = optional(string)
        connection_string        = string
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})
      azure_databricks = optional(map(object({
        name                     = optional(string)
        adb_domain               = string
        msi_workspace_id         = optional(string)
        access_token             = optional(string)
        existing_cluster_id      = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
        key_vault_password = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
        instance_pool = optional(object({
          instance_pool_id      = string
          cluster_version       = string
          min_number_of_workers = optional(number)
          max_number_of_workers = optional(number)
        }))
        new_cluster_config = optional(object({
          cluster_version             = string
          node_type                   = string
          driver_node_type            = optional(string)
          log_destination             = optional(string)
          min_number_of_workers       = optional(number)
          max_number_of_workers       = optional(number)
          custom_tags                 = optional(map(string))
          spark_config                = optional(map(string))
          spark_environment_variables = optional(map(string))
          init_scripts                = optional(list(string))
        }))
      })), {})
      azure_file_storage = optional(map(object({
        name                     = optional(string)
        connection_string        = string
        host                     = optional(string)
        user_id                  = optional(string)
        password                 = optional(string)
        file_share               = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
        key_vault_password = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
      })), {})
      azure_function = optional(map(object({
        name                     = optional(string)
        url                      = string
        key                      = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
        key_vault_key = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
      })), {})
      azure_search = optional(map(object({
        name                     = optional(string)
        url                      = string
        search_service_key       = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})
      cosmosdb = optional(map(object({
        name                     = optional(string)
        account_endpoint         = string
        account_key              = optional(string)
        database                 = string
        connection_string        = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})
      cosmosdb_mongoapi = optional(map(object({
        name                           = optional(string)
        connection_string              = string
        database                       = string
        server_version_is_32_or_higher = optional(bool)
        description                    = optional(string)
        integration_runtime_name       = optional(string)
        annotations                    = optional(list(string))
        parameters                     = optional(map(string))
        additional_properties          = optional(map(string))
      })), {})
      data_lake_storage_gen2 = optional(map(object({
        name                     = optional(string)
        url                      = string
        use_managed_identity     = optional(bool)
        storage_account_key      = optional(string)
        service_principal_id     = optional(string)
        service_principal_key    = optional(string)
        tenant                   = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})
      key_vault = optional(map(object({
        name                     = optional(string)
        key_vault_id             = string
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})
      kusto = optional(map(object({
        name                     = optional(string)
        kusto_endpoint           = string
        kusto_database_name      = string
        use_managed_identity     = optional(bool)
        service_principal_id     = optional(string)
        service_principal_key    = optional(string)
        tenant                   = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})
      mysql = optional(map(object({
        name                     = optional(string)
        connection_string        = string
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})
      odata = optional(map(object({
        name                     = optional(string)
        url                      = string
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
        basic_authentication = optional(object({
          username = string
          password = string
        }))
      })), {})
      odbc = optional(map(object({
        name                     = optional(string)
        connection_string        = string
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
        basic_authentication = optional(object({
          username = string
          password = string
        }))
      })), {})
      postgresql = optional(map(object({
        name                     = optional(string)
        connection_string        = string
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})
      sftp = optional(map(object({
        name                     = optional(string)
        authentication_type      = string
        host                     = string
        port                     = optional(number)
        username                 = optional(string)
        password                 = optional(string)
        private_key_path         = optional(string)
        private_key_passphrase   = optional(string)
        skip_host_key_validation = optional(bool)
        host_key_fingerprint     = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
        key_vault_password = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
        key_vault_private_key_content_base64 = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
        key_vault_private_key_passphrase = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
      })), {})
      snowflake = optional(map(object({
        name                     = optional(string)
        connection_string        = string
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
        key_vault_password = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
      })), {})
      sql_managed_instance = optional(map(object({
        name                     = optional(string)
        connection_string        = string
        service_principal_id     = optional(string)
        service_principal_key    = optional(string)
        tenant                   = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
        key_vault_connection_string = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
        key_vault_password = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
      })), {})
      sql_server = optional(map(object({
        name                     = optional(string)
        connection_string        = string
        user_name                = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
        key_vault_connection_string = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
        key_vault_password = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
      })), {})
      synapse = optional(map(object({
        name                     = optional(string)
        connection_string        = string
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
        key_vault_password = optional(object({
          linked_service_name = string
          secret_name         = string
        }))
      })), {})
      web = optional(map(object({
        name                     = optional(string)
        url                      = string
        authentication_type      = string
        username                 = optional(string)
        password                 = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})
      custom = optional(map(object({
        name                  = optional(string)
        type                  = string
        type_properties       = map(any)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        additional_properties = optional(map(string))
        integration_runtime = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
      })), {})
    }), {})
    datasets = optional(object({
      azure_blob = optional(map(object({
        name                     = optional(string)
        linked_service_name      = string
        path                     = optional(string)
        filename                 = optional(string)
        dynamic_path_enabled     = optional(bool)
        dynamic_filename_enabled = optional(bool)
        description              = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        folder                   = optional(string)
        additional_properties    = optional(map(string))
        schema_column = optional(list(object({
          name        = string
          type        = optional(string)
          description = optional(string)
        })))
      })), {})
      azure_sql_table = optional(map(object({
        name                  = optional(string)
        linked_service_id     = string
        table                 = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))
        schema_column = optional(list(object({
          name        = string
          type        = optional(string)
          description = optional(string)
        })))
      })), {})
      binary = optional(map(object({
        name                  = optional(string)
        linked_service_name   = string
        folder                = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        additional_properties = optional(map(string))
        azure_blob_storage_location = optional(object({
          container                 = string
          path                      = optional(string)
          filename                  = optional(string)
          dynamic_container_enabled = optional(bool)
          dynamic_path_enabled      = optional(bool)
          dynamic_filename_enabled  = optional(bool)
        }))
        http_server_location = optional(object({
          relative_url             = string
          path                     = optional(string)
          filename                 = optional(string)
          dynamic_path_enabled     = optional(bool)
          dynamic_filename_enabled = optional(bool)
        }))
        sftp_server_location = optional(object({
          path                     = string
          filename                 = optional(string)
          dynamic_path_enabled     = optional(bool)
          dynamic_filename_enabled = optional(bool)
        }))
        compression = optional(object({
          type  = string
          level = optional(string)
        }))
      })), {})
      cosmosdb_sqlapi = optional(map(object({
        name                  = optional(string)
        linked_service_name   = string
        collection_name       = string
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))
        schema_column = optional(list(object({
          name        = string
          type        = optional(string)
          description = optional(string)
        })))
      })), {})
      delimited_text = optional(map(object({
        name                  = optional(string)
        linked_service_name   = string
        column_delimiter      = optional(string)
        row_delimiter         = optional(string)
        encoding              = optional(string)
        quote_character       = optional(string)
        escape_character      = optional(string)
        first_row_as_header   = optional(bool)
        null_value            = optional(string)
        compression_codec     = optional(string)
        compression_level     = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))
        azure_blob_storage_location = optional(object({
          container                 = string
          path                      = optional(string)
          filename                  = optional(string)
          dynamic_container_enabled = optional(bool)
          dynamic_path_enabled      = optional(bool)
          dynamic_filename_enabled  = optional(bool)
        }))
        http_server_location = optional(object({
          relative_url             = string
          path                     = optional(string)
          filename                 = optional(string)
          dynamic_path_enabled     = optional(bool)
          dynamic_filename_enabled = optional(bool)
        }))
        azure_blob_fs_location = optional(object({
          file_system                 = string
          path                        = optional(string)
          filename                    = optional(string)
          dynamic_file_system_enabled = optional(bool)
          dynamic_path_enabled        = optional(bool)
          dynamic_filename_enabled    = optional(bool)
        }))
        schema_column = optional(list(object({
          name        = string
          type        = optional(string)
          description = optional(string)
        })))
      })), {})
      http = optional(map(object({
        name                  = optional(string)
        linked_service_name   = string
        relative_url          = optional(string)
        request_body          = optional(string)
        request_method        = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))
        schema_column = optional(list(object({
          name        = string
          type        = optional(string)
          description = optional(string)
        })))
      })), {})
      json = optional(map(object({
        name                  = optional(string)
        linked_service_name   = string
        encoding              = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))
        azure_blob_storage_location = optional(object({
          container                 = string
          path                      = optional(string)
          filename                  = optional(string)
          dynamic_container_enabled = optional(bool)
          dynamic_path_enabled      = optional(bool)
          dynamic_filename_enabled  = optional(bool)
        }))
        http_server_location = optional(object({
          relative_url             = string
          path                     = optional(string)
          filename                 = optional(string)
          dynamic_path_enabled     = optional(bool)
          dynamic_filename_enabled = optional(bool)
        }))
        schema_column = optional(list(object({
          name        = string
          type        = optional(string)
          description = optional(string)
        })))
      })), {})
      mysql = optional(map(object({
        name                  = optional(string)
        linked_service_name   = string
        table_name            = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))
        schema_column = optional(list(object({
          name        = string
          type        = optional(string)
          description = optional(string)
        })))
      })), {})
      parquet = optional(map(object({
        name                  = optional(string)
        linked_service_name   = string
        compression_codec     = optional(string)
        compression_level     = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))
        azure_blob_storage_location = optional(object({
          container                 = string
          path                      = optional(string)
          filename                  = optional(string)
          dynamic_container_enabled = optional(bool)
          dynamic_path_enabled      = optional(bool)
          dynamic_filename_enabled  = optional(bool)
        }))
        azure_blob_fs_location = optional(object({
          file_system                 = string
          path                        = optional(string)
          filename                    = optional(string)
          dynamic_file_system_enabled = optional(bool)
          dynamic_path_enabled        = optional(bool)
          dynamic_filename_enabled    = optional(bool)
        }))
        http_server_location = optional(object({
          relative_url             = string
          path                     = optional(string)
          filename                 = optional(string)
          dynamic_path_enabled     = optional(bool)
          dynamic_filename_enabled = optional(bool)
        }))
        schema_column = optional(list(object({
          name        = string
          type        = optional(string)
          description = optional(string)
        })))
      })), {})
      postgresql = optional(map(object({
        name                  = optional(string)
        linked_service_name   = string
        table_name            = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))
        schema_column = optional(list(object({
          name        = string
          type        = optional(string)
          description = optional(string)
        })))
      })), {})
      snowflake = optional(map(object({
        name                  = optional(string)
        linked_service_name   = string
        schema_name           = string
        table_name            = string
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))
        schema_column = optional(list(object({
          name      = string
          type      = optional(string)
          precision = optional(number)
          scale     = optional(number)
        })))
      })), {})
      sql_server_table = optional(map(object({
        name                  = optional(string)
        linked_service_name   = string
        table_name            = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))
        schema_column = optional(list(object({
          name        = string
          type        = optional(string)
          description = optional(string)
        })))
      })), {})
      custom = optional(map(object({
        name                  = optional(string)
        type                  = string
        type_properties       = map(any)
        schema_json           = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))
        linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
      })), {})
    }), {})
    data_flows = optional(map(object({
      name         = optional(string)
      description  = optional(string)
      folder       = optional(string)
      annotations  = optional(list(string))
      script       = optional(string)
      script_lines = optional(list(string))
      source = optional(list(object({
        name        = string
        description = optional(string)
        linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        dataset = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        flowlet = optional(object({
          name               = string
          parameters         = optional(map(string))
          dataset_parameters = optional(string)
        }))
        schema_linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        rejected_linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
      })))
      sink = optional(list(object({
        name        = string
        description = optional(string)
        linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        dataset = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        flowlet = optional(object({
          name               = string
          parameters         = optional(map(string))
          dataset_parameters = optional(string)
        }))
        schema_linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        rejected_linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
      })))
      transformation = optional(list(object({
        name        = string
        description = optional(string)
        linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        dataset = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        flowlet = optional(object({
          name               = string
          parameters         = optional(map(string))
          dataset_parameters = optional(string)
        }))
      })))
    })), {})
    flowlet_data_flows = optional(map(object({
      name         = optional(string)
      description  = optional(string)
      folder       = optional(string)
      annotations  = optional(list(string))
      script       = optional(string)
      script_lines = optional(list(string))
      source = optional(list(object({
        name        = string
        description = optional(string)
        linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        dataset = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        flowlet = optional(object({
          name               = string
          parameters         = optional(map(string))
          dataset_parameters = optional(string)
        }))
        schema_linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        rejected_linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
      })))
      sink = optional(list(object({
        name        = string
        description = optional(string)
        linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        dataset = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        flowlet = optional(object({
          name               = string
          parameters         = optional(map(string))
          dataset_parameters = optional(string)
        }))
        schema_linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        rejected_linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
      })))
      transformation = optional(list(object({
        name        = string
        description = optional(string)
        linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        dataset = optional(object({
          name       = string
          parameters = optional(map(string))
        }))
        flowlet = optional(object({
          name               = string
          parameters         = optional(map(string))
          dataset_parameters = optional(string)
        }))
      })))
    })), {})
    integration_runtimes = optional(object({
      azure = optional(map(object({
        name                    = optional(string)
        location                = string
        compute_type            = optional(string)
        core_count              = optional(number)
        time_to_live_min        = optional(number)
        cleanup_enabled         = optional(bool)
        virtual_network_enabled = optional(bool)
        description             = optional(string)
      })), {})
      azure_ssis = optional(map(object({
        name                             = optional(string)
        location                         = string
        node_size                        = string
        number_of_nodes                  = optional(number)
        credential_name                  = optional(string)
        edition                          = optional(string)
        license_type                     = optional(string)
        max_parallel_executions_per_node = optional(number)
        description                      = optional(string)
        vnet_integration = optional(object({
          vnet_id     = string
          subnet_name = string
          public_ips  = optional(list(string))
          subnet_id   = optional(string)
        }))
        catalog_info = optional(object({
          server_endpoint        = string
          administrator_login    = string
          administrator_password = string
          pricing_tier           = optional(string)
          elastic_pool_name      = optional(string)
          dual_standby_pair_name = optional(string)
        }))
        copy_compute_scale = optional(object({
          data_integration_unit = optional(number)
          time_to_live          = optional(number)
        }))
        custom_setup_script = optional(object({
          blob_container_uri = string
          sas_token          = string
        }))
        express_custom_setup = optional(object({
          environment        = optional(map(string))
          powershell_version = optional(string)
          command_key = optional(object({
            target_name = string
            user_name   = string
            password    = optional(string)
            key_vault_password = optional(object({
              linked_service_name = string
              secret_name         = string
              secret_version      = optional(string)
              parameters          = optional(map(string))
            }))
          }))
          component = optional(list(object({
            name    = string
            license = optional(string)
            key_vault_license = optional(object({
              linked_service_name = string
              secret_name         = string
              secret_version      = optional(string)
              parameters          = optional(map(string))
            }))
          })))
        }))
        package_store = optional(object({
          name                = string
          linked_service_name = string
        }))
        proxy = optional(object({
          self_hosted_integration_runtime_name = string
          staging_storage_linked_service_name  = string
          path                                 = optional(string)
        }))
        pipeline_external_compute_scale = optional(object({
          number_of_external_nodes = optional(number)
          number_of_pipeline_nodes = optional(number)
          time_to_live             = optional(number)
        }))
      })), {})
      self_hosted = optional(map(object({
        name                                         = optional(string)
        description                                  = optional(string)
        self_contained_interactive_authoring_enabled = optional(bool)
        rbac_authorization_config = optional(object({
          resource_id = string
        }))
      })), {})
    }), {})
    pipelines = optional(map(object({
      name                           = optional(string)
      activities                     = any
      description                    = optional(string)
      annotations                    = optional(list(string))
      concurrency                    = optional(number)
      moniter_metrics_after_duration = optional(string)
      parameters                     = optional(map(string))
      variables                      = optional(map(string))
      folder                         = optional(string)
    })), {})
    triggers = optional(object({
      blob_event = optional(map(object({
        name                  = optional(string)
        storage_account_id    = string
        events                = list(string)
        blob_path_begins_with = optional(string)
        blob_path_ends_with   = optional(string)
        ignore_empty_blobs    = optional(bool)
        description           = optional(string)
        annotations           = optional(list(string))
        activated             = optional(bool)
        additional_properties = optional(map(string))
        pipelines = optional(list(object({
          name       = string
          parameters = optional(map(string))
        })))
      })), {})
      schedule = optional(map(object({
        name                = optional(string)
        frequency           = string
        interval            = number
        start_time          = optional(string)
        end_time            = optional(string)
        time_zone           = optional(string)
        description         = optional(string)
        annotations         = optional(list(string))
        activated           = optional(bool)
        pipeline_name       = optional(string)
        pipeline_parameters = optional(map(string))
        pipelines = optional(list(object({
          name       = string
          parameters = optional(map(string))
        })))
        schedule = optional(object({
          minutes       = optional(list(number))
          hours         = optional(list(number))
          days_of_week  = optional(list(string))
          days_of_month = optional(list(number))
          monthly = optional(object({
            weekday = string
            week    = number
          }))
        }))
      })), {})
      tumbling_window = optional(map(object({
        name                  = optional(string)
        frequency             = string
        interval              = number
        start_time            = string
        end_time              = optional(string)
        delay                 = optional(string)
        max_concurrency       = optional(number)
        description           = optional(string)
        annotations           = optional(list(string))
        activated             = optional(bool)
        additional_properties = optional(map(string))
        pipelines = optional(list(object({
          name       = string
          parameters = optional(map(string))
        })))
        retry = optional(object({
          count    = optional(number)
          interval = optional(number)
        }))
        trigger_dependencies = optional(list(object({
          offset       = optional(string)
          size         = optional(string)
          trigger_name = optional(string)
        })))
      })), {})
      custom_event = optional(map(object({
        name                  = optional(string)
        eventgrid_topic_id    = string
        events                = list(string)
        subject_begins_with   = optional(string)
        subject_ends_with     = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        activated             = optional(bool)
        additional_properties = optional(map(string))
        pipelines = optional(list(object({
          name       = string
          parameters = optional(map(string))
        })))
      })), {})
    }), {})
    managed_private_endpoints = optional(map(object({
      name               = optional(string)
      target_resource_id = string
      subresource_name   = string
      fqdns              = optional(list(string))
    })), {})
    customer_managed_key = optional(object({
      customer_managed_key_id   = string
      user_assigned_identity_id = optional(string)
    }))
  })
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_location"></a> [location](#input\_location)

Description: default azure region to be used.

Type: `string`

Default: `null`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: default resource group to be used.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_credentials"></a> [credentials](#output\_credentials)

Description: contains all data factory credentials

### <a name="output_customer_managed_key"></a> [customer\_managed\_key](#output\_customer\_managed\_key)

Description: contains data factory customer managed key configuration

### <a name="output_data_flows"></a> [data\_flows](#output\_data\_flows)

Description: contains all data factory data flows

### <a name="output_datasets"></a> [datasets](#output\_datasets)

Description: contains all data factory datasets

### <a name="output_instance"></a> [instance](#output\_instance)

Description: contains all data factory configuration

### <a name="output_integration_runtimes"></a> [integration\_runtimes](#output\_integration\_runtimes)

Description: contains all data factory integration runtimes

### <a name="output_linked_services"></a> [linked\_services](#output\_linked\_services)

Description: contains all data factory linked services

### <a name="output_managed_private_endpoints"></a> [managed\_private\_endpoints](#output\_managed\_private\_endpoints)

Description: contains all data factory managed private endpoints

### <a name="output_pipelines"></a> [pipelines](#output\_pipelines)

Description: contains all data factory pipelines

### <a name="output_triggers"></a> [triggers](#output\_triggers)

Description: contains all data factory triggers
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md). <br><br>

<a href="https://github.com/cloudnationhq/terraform-azure-adf/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudnationhq/terraform-azure-adf" />
</a>

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/data-factory/)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/datafactory/)
- [Rest Api Specs](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/datafactory)
