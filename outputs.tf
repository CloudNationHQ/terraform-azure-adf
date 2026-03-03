output "instance" {
  description = "contains all data factory configuration"
  value       = azurerm_data_factory.this
}

output "credentials" {
  description = "contains all data factory credentials"
  value = {
    service_principal     = azurerm_data_factory_credential_service_principal.this
    user_managed_identity = azurerm_data_factory_credential_user_managed_identity.this
  }
}

output "linked_services" {
  description = "contains all data factory linked services"
  value = {
    azure_blob_storage     = azurerm_data_factory_linked_service_azure_blob_storage.this
    azure_sql_database     = azurerm_data_factory_linked_service_azure_sql_database.this
    azure_table_storage    = azurerm_data_factory_linked_service_azure_table_storage.this
    azure_databricks       = azurerm_data_factory_linked_service_azure_databricks.this
    azure_file_storage     = azurerm_data_factory_linked_service_azure_file_storage.this
    azure_function         = azurerm_data_factory_linked_service_azure_function.this
    azure_search           = azurerm_data_factory_linked_service_azure_search.this
    cosmosdb               = azurerm_data_factory_linked_service_cosmosdb.this
    cosmosdb_mongoapi      = azurerm_data_factory_linked_service_cosmosdb_mongoapi.this
    data_lake_storage_gen2 = azurerm_data_factory_linked_service_data_lake_storage_gen2.this
    key_vault              = azurerm_data_factory_linked_service_key_vault.this
    kusto                  = azurerm_data_factory_linked_service_kusto.this
    mysql                  = azurerm_data_factory_linked_service_mysql.this
    odata                  = azurerm_data_factory_linked_service_odata.this
    odbc                   = azurerm_data_factory_linked_service_odbc.this
    postgresql             = azurerm_data_factory_linked_service_postgresql.this
    sftp                   = azurerm_data_factory_linked_service_sftp.this
    snowflake              = azurerm_data_factory_linked_service_snowflake.this
    sql_managed_instance   = azurerm_data_factory_linked_service_sql_managed_instance.this
    sql_server             = azurerm_data_factory_linked_service_sql_server.this
    synapse                = azurerm_data_factory_linked_service_synapse.this
    web                    = azurerm_data_factory_linked_service_web.this
    custom                 = azurerm_data_factory_linked_service_custom.this
  }
}

output "datasets" {
  description = "contains all data factory datasets"
  value = {
    azure_blob       = azurerm_data_factory_dataset_azure_blob.this
    azure_sql_table  = azurerm_data_factory_dataset_azure_sql_table.this
    binary           = azurerm_data_factory_dataset_binary.this
    cosmosdb_sqlapi  = azurerm_data_factory_dataset_cosmosdb_sqlapi.this
    delimited_text   = azurerm_data_factory_dataset_delimited_text.this
    http             = azurerm_data_factory_dataset_http.this
    json             = azurerm_data_factory_dataset_json.this
    mysql            = azurerm_data_factory_dataset_mysql.this
    parquet          = azurerm_data_factory_dataset_parquet.this
    postgresql       = azurerm_data_factory_dataset_postgresql.this
    snowflake        = azurerm_data_factory_dataset_snowflake.this
    sql_server_table = azurerm_data_factory_dataset_sql_server_table.this
    custom           = azurerm_data_factory_custom_dataset.this
  }
}

output "data_flows" {
  description = "contains all data factory data flows"
  value = {
    flows    = azurerm_data_factory_data_flow.this
    flowlets = azurerm_data_factory_flowlet_data_flow.this
  }
}

output "integration_runtimes" {
  description = "contains all data factory integration runtimes"
  value = {
    azure       = azurerm_data_factory_integration_runtime_azure.this
    azure_ssis  = azurerm_data_factory_integration_runtime_azure_ssis.this
    self_hosted = azurerm_data_factory_integration_runtime_self_hosted.this
  }
}

output "pipelines" {
  description = "contains all data factory pipelines"
  value       = azurerm_data_factory_pipeline.this
}

output "triggers" {
  description = "contains all data factory triggers"
  value = {
    blob_event      = azurerm_data_factory_trigger_blob_event.this
    schedule        = azurerm_data_factory_trigger_schedule.this
    tumbling_window = azurerm_data_factory_trigger_tumbling_window.this
    custom_event    = azurerm_data_factory_trigger_custom_event.this
  }
}

output "managed_private_endpoints" {
  description = "contains all data factory managed private endpoints"
  value       = azurerm_data_factory_managed_private_endpoint.this
}

output "customer_managed_key" {
  description = "contains data factory customer managed key configuration"
  value       = azurerm_data_factory_customer_managed_key.this
}
