locals {
  naming = {
    # lookup outputs to have consistent naming
    for type in local.naming_types : type => lookup(module.naming, type).name
  }

  naming_types = [
    "data_factory_dataset_azure_blob",
    "data_factory_dataset_delimited_text",
    "data_factory_dataset_sql_server_table",
    "data_factory_linked_service_azure_blob_storage",
    "data_factory_linked_service_sql_server",
    "data_factory_pipeline"
  ]
}
