resource "azurerm_data_factory" "this" {
  name                             = var.instance.name
  location                         = coalesce(lookup(var.instance, "location", null), var.location)
  resource_group_name              = coalesce(lookup(var.instance, "resource_group_name", null), var.resource_group_name)
  managed_virtual_network_enabled  = var.instance.managed_virtual_network_enabled
  public_network_enabled           = var.instance.public_network_enabled
  customer_managed_key_id          = var.instance.customer_managed_key_id
  customer_managed_key_identity_id = var.instance.customer_managed_key_identity_id
  purview_id                       = var.instance.purview_id
  tags                             = coalesce(var.instance.tags, var.tags)

  dynamic "identity" {
    for_each = lookup(var.instance, "identity", null) != null ? [var.instance.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "vsts_configuration" {
    for_each = lookup(var.instance, "vsts_configuration", null) != null ? [var.instance.vsts_configuration] : []
    content {
      account_name       = vsts_configuration.value.account_name
      branch_name        = vsts_configuration.value.branch_name
      project_name       = vsts_configuration.value.project_name
      repository_name    = vsts_configuration.value.repository_name
      root_folder        = vsts_configuration.value.root_folder
      tenant_id          = vsts_configuration.value.tenant_id
      publishing_enabled = vsts_configuration.value.publishing_enabled
    }
  }

  dynamic "github_configuration" {
    for_each = lookup(var.instance, "github_configuration", null) != null ? [var.instance.github_configuration] : []
    content {
      account_name       = github_configuration.value.account_name
      branch_name        = github_configuration.value.branch_name
      git_url            = github_configuration.value.git_url
      repository_name    = github_configuration.value.repository_name
      root_folder        = github_configuration.value.root_folder
      publishing_enabled = github_configuration.value.publishing_enabled
    }
  }

  dynamic "global_parameter" {
    for_each = var.instance.global_parameters
    content {
      name  = global_parameter.value.name
      type  = global_parameter.value.type
      value = global_parameter.value.value
    }
  }
}

# Credentials
resource "azurerm_data_factory_credential_service_principal" "this" {
  for_each = var.instance.credentials.service_principal

  name                 = each.value.name
  data_factory_id      = azurerm_data_factory.this.id
  tenant_id            = each.value.tenant_id
  service_principal_id = each.value.service_principal_id
  description          = each.value.description
  annotations          = each.value.annotations

  dynamic "service_principal_key" {
    for_each = lookup(each.value, "service_principal_key", null) != null ? [each.value.service_principal_key] : []
    content {
      linked_service_name = service_principal_key.value.linked_service_name
      secret_name         = service_principal_key.value.secret_name
      secret_version      = service_principal_key.value.secret_version
    }
  }
}

resource "azurerm_data_factory_credential_user_managed_identity" "this" {
  for_each = var.instance.credentials.user_managed_identity

  name            = each.value.name
  data_factory_id = azurerm_data_factory.this.id
  identity_id     = each.value.identity_id
  description     = each.value.description
  annotations     = each.value.annotations
}

# Linked Services
resource "azurerm_data_factory_linked_service_azure_blob_storage" "this" {
  for_each = var.instance.linked_services.azure_blob_storage

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  use_managed_identity     = each.value.use_managed_identity
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties
  connection_string        = each.value.connection_string
  sas_uri                  = each.value.sas_uri
  service_endpoint         = each.value.service_endpoint
  service_principal_id     = each.value.service_principal_id
  service_principal_key    = each.value.service_principal_key
  storage_kind             = each.value.storage_kind
  tenant_id                = each.value.tenant_id

  dynamic "sas_token_linked_key_vault_key" {
    for_each = lookup(each.value, "sas_token_linked_key_vault_key", null) != null ? [each.value.sas_token_linked_key_vault_key] : []
    content {
      linked_service_name = sas_token_linked_key_vault_key.value.linked_service_name
      secret_name         = sas_token_linked_key_vault_key.value.secret_name
    }
  }
}

resource "azurerm_data_factory_linked_service_azure_sql_database" "this" {
  for_each = var.instance.linked_services.azure_sql_database

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  connection_string        = each.value.connection_string
  use_managed_identity     = each.value.use_managed_identity
  service_principal_id     = each.value.service_principal_id
  service_principal_key    = each.value.service_principal_key
  tenant_id                = each.value.tenant_id
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties
  credential_name          = each.value.credential_name

  dynamic "key_vault_connection_string" {
    for_each = lookup(each.value, "key_vault_connection_string", null) != null ? [each.value.key_vault_connection_string] : []
    content {
      linked_service_name = key_vault_connection_string.value.linked_service_name
      secret_name         = key_vault_connection_string.value.secret_name
    }
  }

  dynamic "key_vault_password" {
    for_each = lookup(each.value, "key_vault_password", null) != null ? [each.value.key_vault_password] : []
    content {
      linked_service_name = key_vault_password.value.linked_service_name
      secret_name         = key_vault_password.value.secret_name
    }
  }
}

######## IIII AMMMM HEEEERRREEEEEE ########################################

resource "azurerm_data_factory_linked_service_azure_table_storage" "this" {
  for_each = var.instance.linked_services.azure_table_storage

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  connection_string        = each.value.connection_string
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties
}

resource "azurerm_data_factory_linked_service_azure_databricks" "this" {
  for_each = var.instance.linked_services.azure_databricks

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  adb_domain               = each.value.adb_domain
  access_token             = each.value.access_token
  msi_workspace_id         = each.value.msi_workspace_id
  existing_cluster_id      = each.value.existing_cluster_id
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties

  dynamic "key_vault_password" {
    for_each = lookup(each.value, "key_vault_password", null) != null ? [each.value.key_vault_password] : []
    content {
      linked_service_name = key_vault_password.value.linked_service_name
      secret_name         = key_vault_password.value.secret_name
    }
  }

  dynamic "new_cluster_config" {
    for_each = lookup(each.value, "new_cluster_config", null) != null ? [each.value.new_cluster_config] : []
    content {
      cluster_version             = new_cluster_config.value.cluster_version
      node_type                   = new_cluster_config.value.node_type
      driver_node_type            = new_cluster_config.value.driver_node_type
      min_number_of_workers       = new_cluster_config.value.min_number_of_workers
      max_number_of_workers       = new_cluster_config.value.max_number_of_workers
      log_destination             = new_cluster_config.value.log_destination
      custom_tags                 = new_cluster_config.value.custom_tags
      spark_config                = new_cluster_config.value.spark_config
      spark_environment_variables = new_cluster_config.value.spark_environment_variables
      init_scripts                = new_cluster_config.value.init_scripts
    }
  }

  dynamic "instance_pool" {
    for_each = lookup(each.value, "instance_pool", null) != null ? [each.value.instance_pool] : []
    content {
      instance_pool_id      = instance_pool.value.instance_pool_id
      cluster_version       = instance_pool.value.cluster_version
      min_number_of_workers = instance_pool.value.min_number_of_workers
      max_number_of_workers = instance_pool.value.max_number_of_workers
    }
  }
}

resource "azurerm_data_factory_linked_service_azure_file_storage" "this" {
  for_each = var.instance.linked_services.azure_file_storage

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  description              = each.value.description
  host                     = each.value.host
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  password                 = each.value.password
  user_id                  = each.value.user_id
  additional_properties    = each.value.additional_properties
  connection_string        = each.value.connection_string
  file_share               = each.value.file_share

  dynamic "key_vault_password" {
    for_each = lookup(each.value, "key_vault_password", null) != null ? [each.value.key_vault_password] : []
    content {
      linked_service_name = key_vault_password.value.linked_service_name
      secret_name         = key_vault_password.value.secret_name
    }
  }
}

resource "azurerm_data_factory_linked_service_azure_function" "this" {
  for_each = var.instance.linked_services.azure_function

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  url                      = each.value.url
  key                      = each.value.key
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties

  dynamic "key_vault_key" {
    for_each = lookup(each.value, "key_vault_key", null) != null ? [each.value.key_vault_key] : []
    content {
      linked_service_name = key_vault_key.value.linked_service_name
      secret_name         = key_vault_key.value.secret_name
    }
  }
}

resource "azurerm_data_factory_linked_service_azure_search" "this" {
  for_each = var.instance.linked_services.azure_search

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  url                      = each.value.url
  search_service_key       = each.value.search_service_key
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties
}

resource "azurerm_data_factory_linked_service_cosmosdb" "this" {
  for_each = var.instance.linked_services.cosmosdb

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  account_endpoint         = each.value.account_endpoint
  account_key              = each.value.account_key
  database                 = each.value.database
  connection_string        = each.value.connection_string
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
}

resource "azurerm_data_factory_linked_service_cosmosdb_mongoapi" "this" {
  for_each = var.instance.linked_services.cosmosdb_mongoapi

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  connection_string        = each.value.connection_string
  database                 = each.value.database
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "this" {
  for_each = var.instance.linked_services.data_lake_storage_gen2

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  url                      = each.value.url
  use_managed_identity     = each.value.use_managed_identity
  storage_account_key      = each.value.storage_account_key
  service_principal_id     = each.value.service_principal_id
  service_principal_key    = each.value.service_principal_key
  tenant_id                = each.value.tenant_id
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
}

resource "azurerm_data_factory_linked_service_key_vault" "this" {
  for_each = var.instance.linked_services.key_vault

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  key_vault_id             = each.value.key_vault_id
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
}

resource "azurerm_data_factory_linked_service_kusto" "this" {
  for_each = var.instance.linked_services.kusto

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  kusto_endpoint           = each.value.kusto_endpoint
  kusto_database_name      = each.value.kusto_database_name
  use_managed_identity     = each.value.use_managed_identity
  service_principal_id     = each.value.service_principal_id
  service_principal_key    = each.value.service_principal_key
  tenant_id                = each.value.tenant_id
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
}

resource "azurerm_data_factory_linked_service_mysql" "this" {
  for_each = var.instance.linked_services.mysql

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  connection_string        = each.value.connection_string
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties

  dynamic "key_vault_password" {
    for_each = lookup(each.value, "key_vault_password", null) != null ? [each.value.key_vault_password] : []
    content {
      linked_service_name = key_vault_password.value.linked_service_name
      secret_name         = key_vault_password.value.secret_name
    }
  }
}

resource "azurerm_data_factory_linked_service_odata" "this" {
  for_each = var.instance.linked_services.odata

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  url                      = each.value.url
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties

  dynamic "basic_authentication" {
    for_each = lookup(each.value, "basic_authentication", null) != null ? [each.value.basic_authentication] : []
    content {
      username = basic_authentication.value.username
      password = basic_authentication.value.password
    }
  }
}

resource "azurerm_data_factory_linked_service_odbc" "this" {
  for_each = var.instance.linked_services.odbc

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  connection_string        = each.value.connection_string
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties

  dynamic "basic_authentication" {
    for_each = lookup(each.value, "basic_authentication", null) != null ? [each.value.basic_authentication] : []
    content {
      username = basic_authentication.value.username
      password = basic_authentication.value.password
    }
  }
}

resource "azurerm_data_factory_linked_service_postgresql" "this" {
  for_each = var.instance.linked_services.postgresql

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  connection_string        = each.value.connection_string
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties

  dynamic "key_vault_password" {
    for_each = lookup(each.value, "key_vault_password", null) != null ? [each.value.key_vault_password] : []
    content {
      linked_service_name = key_vault_password.value.linked_service_name
      secret_name         = key_vault_password.value.secret_name
    }
  }
}

resource "azurerm_data_factory_linked_service_sftp" "this" {
  for_each = var.instance.linked_services.sftp

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  authentication_type      = each.value.authentication_type
  host                     = each.value.host
  port                     = each.value.port
  username                 = each.value.username
  password                 = each.value.password
  private_key_path         = each.value.private_key_path
  private_key_passphrase   = each.value.private_key_passphrase
  skip_host_key_validation = each.value.skip_host_key_validation
  host_key_fingerprint     = each.value.host_key_fingerprint
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
}

resource "azurerm_data_factory_linked_service_snowflake" "this" {
  for_each = var.instance.linked_services.snowflake

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  connection_string        = each.value.connection_string
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties

  dynamic "key_vault_password" {
    for_each = lookup(each.value, "key_vault_password", null) != null ? [each.value.key_vault_password] : []
    content {
      linked_service_name = key_vault_password.value.linked_service_name
      secret_name         = key_vault_password.value.secret_name
    }
  }
}

resource "azurerm_data_factory_linked_service_sql_managed_instance" "this" {
  for_each = var.instance.linked_services.sql_managed_instance

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  connection_string        = each.value.connection_string
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties

  dynamic "key_vault_password" {
    for_each = lookup(each.value, "key_vault_password", null) != null ? [each.value.key_vault_password] : []
    content {
      linked_service_name = key_vault_password.value.linked_service_name
      secret_name         = key_vault_password.value.secret_name
    }
  }
}

resource "azurerm_data_factory_linked_service_sql_server" "this" {
  for_each = var.instance.linked_services.sql_server

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  connection_string        = each.value.connection_string
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties

  dynamic "key_vault_password" {
    for_each = lookup(each.value, "key_vault_password", null) != null ? [each.value.key_vault_password] : []
    content {
      linked_service_name = key_vault_password.value.linked_service_name
      secret_name         = key_vault_password.value.secret_name
    }
  }
}

resource "azurerm_data_factory_linked_service_synapse" "this" {
  for_each = var.instance.linked_services.synapse

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  connection_string        = each.value.connection_string
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties

  dynamic "key_vault_password" {
    for_each = lookup(each.value, "key_vault_password", null) != null ? [each.value.key_vault_password] : []
    content {
      linked_service_name = key_vault_password.value.linked_service_name
      secret_name         = key_vault_password.value.secret_name
    }
  }
}

resource "azurerm_data_factory_linked_service_web" "this" {
  for_each = var.instance.linked_services.web

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  url                      = each.value.url
  authentication_type      = each.value.authentication_type
  username                 = each.value.username
  password                 = each.value.password
  description              = each.value.description
  integration_runtime_name = each.value.integration_runtime_name
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties
}

resource "azurerm_data_factory_linked_custom_service" "this" {
  for_each = var.instance.linked_services.custom

  name                     = each.value.name
  data_factory_id          = azurerm_data_factory.this.id
  type                     = each.value.type
  type_properties_json     = jsonencode(each.value.type_properties)
  description              = each.value.description
  annotations              = each.value.annotations
  parameters               = each.value.parameters
  additional_properties    = each.value.additional_properties

  dynamic "integration_runtime" {
    for_each = lookup(each.value, "integration_runtime", null) != null ? [each.value.integration_runtime] : []
    content {
      name       = integration_runtime.value.name
      parameters = integration_runtime.value.parameters
    }
  }
}

# Datasets
resource "azurerm_data_factory_dataset_azure_blob" "this" {
  for_each = var.instance.datasets.azure_blob

  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this.id
  linked_service_name = each.value.linked_service_name
  path                = each.value.path
  filename            = each.value.filename
  description         = each.value.description
  annotations         = each.value.annotations
  parameters          = each.value.parameters
  folder              = each.value.folder
  additional_properties = each.value.additional_properties

  dynamic "schema_column" {
    for_each = lookup(each.value, "schema_column", null) != null ? each.value.schema_column : []
    content {
      name        = schema_column.value.name
      type        = schema_column.value.type
      description = schema_column.value.description
    }
  }
}

resource "azurerm_data_factory_dataset_azure_sql_table" "this" {
  for_each = var.instance.datasets.azure_sql_table

  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this.id
  linked_service_name = each.value.linked_service_name
  table_name          = each.value.table_name
  description         = each.value.description
  annotations         = each.value.annotations
  parameters          = each.value.parameters
  folder              = each.value.folder
  additional_properties = each.value.additional_properties

  dynamic "schema_column" {
    for_each = lookup(each.value, "schema_column", null) != null ? each.value.schema_column : []
    content {
      name        = schema_column.value.name
      type        = schema_column.value.type
      description = schema_column.value.description
    }
  }
}

resource "azurerm_data_factory_dataset_binary" "this" {
  for_each = var.instance.datasets.binary

  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this.id
  linked_service_name = each.value.linked_service_name
  folder              = each.value.folder
  description         = each.value.description
  annotations         = each.value.annotations
  parameters          = each.value.parameters
  additional_properties = each.value.additional_properties

  dynamic "azure_blob_storage_location" {
    for_each = lookup(each.value, "azure_blob_storage_location", null) != null ? [each.value.azure_blob_storage_location] : []
    content {
      container = azure_blob_storage_location.value.container
      path      = azure_blob_storage_location.value.path
      filename  = azure_blob_storage_location.value.filename
    }
  }

  dynamic "http_server_location" {
    for_each = lookup(each.value, "http_server_location", null) != null ? [each.value.http_server_location] : []
    content {
      relative_url = http_server_location.value.relative_url
      path         = http_server_location.value.path
      filename     = http_server_location.value.filename
    }
  }

  dynamic "sftp_server_location" {
    for_each = lookup(each.value, "sftp_server_location", null) != null ? [each.value.sftp_server_location] : []
    content {
      path     = sftp_server_location.value.path
      filename = sftp_server_location.value.filename
    }
  }

  dynamic "compression" {
    for_each = lookup(each.value, "compression", null) != null ? [each.value.compression] : []
    content {
      type = compression.value.type
    }
  }
}

resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "this" {
  for_each = var.instance.datasets.cosmosdb_sqlapi

  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this.id
  linked_service_name = each.value.linked_service_name
  collection_name     = each.value.collection_name
  description         = each.value.description
  annotations         = each.value.annotations
  parameters          = each.value.parameters
  folder              = each.value.folder
  additional_properties = each.value.additional_properties
}

resource "azurerm_data_factory_dataset_delimited_text" "this" {
  for_each = var.instance.datasets.delimited_text

  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this.id
  linked_service_name = each.value.linked_service_name
  column_delimiter    = each.value.column_delimiter
  row_delimiter       = each.value.row_delimiter
  encoding            = each.value.encoding
  quote_character     = each.value.quote_character
  escape_character    = each.value.escape_character
  first_row_as_header = each.value.first_row_as_header
  null_value          = each.value.null_value
  compression_codec   = each.value.compression_codec
  compression_level   = each.value.compression_level
  description         = each.value.description
  annotations         = each.value.annotations
  parameters          = each.value.parameters
  folder              = each.value.folder
  additional_properties = each.value.additional_properties

  dynamic "azure_blob_storage_location" {
    for_each = lookup(each.value, "azure_blob_storage_location", null) != null ? [each.value.azure_blob_storage_location] : []
    content {
      container = azure_blob_storage_location.value.container
      path      = azure_blob_storage_location.value.path
      filename  = azure_blob_storage_location.value.filename
    }
  }

  dynamic "http_server_location" {
    for_each = lookup(each.value, "http_server_location", null) != null ? [each.value.http_server_location] : []
    content {
      relative_url = http_server_location.value.relative_url
      path         = http_server_location.value.path
      filename     = http_server_location.value.filename
    }
  }

  dynamic "azure_blob_fs_location" {
    for_each = lookup(each.value, "azure_blob_fs_location", null) != null ? [each.value.azure_blob_fs_location] : []
    content {
      file_system = azure_blob_fs_location.value.file_system
      path        = azure_blob_fs_location.value.path
      filename    = azure_blob_fs_location.value.filename
    }
  }
}

resource "azurerm_data_factory_dataset_http" "this" {
  for_each = var.instance.datasets.http

  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this.id
  linked_service_name = each.value.linked_service_name
  relative_url        = each.value.relative_url
  request_body        = each.value.request_body
  request_method      = each.value.request_method
  description         = each.value.description
  annotations         = each.value.annotations
  parameters          = each.value.parameters
  folder              = each.value.folder
  additional_properties = each.value.additional_properties

  dynamic "schema_column" {
    for_each = lookup(each.value, "schema_column", null) != null ? each.value.schema_column : []
    content {
      name        = schema_column.value.name
      type        = schema_column.value.type
      description = schema_column.value.description
    }
  }
}

resource "azurerm_data_factory_dataset_json" "this" {
  for_each = var.instance.datasets.json

  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this.id
  linked_service_name = each.value.linked_service_name
  encoding            = each.value.encoding
  description         = each.value.description
  annotations         = each.value.annotations
  parameters          = each.value.parameters
  folder              = each.value.folder
  additional_properties = each.value.additional_properties

  dynamic "azure_blob_storage_location" {
    for_each = lookup(each.value, "azure_blob_storage_location", null) != null ? [each.value.azure_blob_storage_location] : []
    content {
      container = azure_blob_storage_location.value.container
      path      = azure_blob_storage_location.value.path
      filename  = azure_blob_storage_location.value.filename
    }
  }

  dynamic "http_server_location" {
    for_each = lookup(each.value, "http_server_location", null) != null ? [each.value.http_server_location] : []
    content {
      relative_url = http_server_location.value.relative_url
      path         = http_server_location.value.path
      filename     = http_server_location.value.filename
    }
  }
}

resource "azurerm_data_factory_dataset_mysql" "this" {
  for_each = var.instance.datasets.mysql

  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this.id
  linked_service_name = each.value.linked_service_name
  table_name          = each.value.table_name
  description         = each.value.description
  annotations         = each.value.annotations
  parameters          = each.value.parameters
  folder              = each.value.folder
  additional_properties = each.value.additional_properties

  dynamic "schema_column" {
    for_each = lookup(each.value, "schema_column", null) != null ? each.value.schema_column : []
    content {
      name        = schema_column.value.name
      type        = schema_column.value.type
      description = schema_column.value.description
    }
  }
}

resource "azurerm_data_factory_dataset_parquet" "this" {
  for_each = var.instance.datasets.parquet

  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this.id
  linked_service_name = each.value.linked_service_name
  compression_codec   = each.value.compression_codec
  compression_level   = each.value.compression_level
  description         = each.value.description
  annotations         = each.value.annotations
  parameters          = each.value.parameters
  folder              = each.value.folder
  additional_properties = each.value.additional_properties

  dynamic "azure_blob_storage_location" {
    for_each = lookup(each.value, "azure_blob_storage_location", null) != null ? [each.value.azure_blob_storage_location] : []
    content {
      container = azure_blob_storage_location.value.container
      path      = azure_blob_storage_location.value.path
      filename  = azure_blob_storage_location.value.filename
    }
  }

  dynamic "http_server_location" {
    for_each = lookup(each.value, "http_server_location", null) != null ? [each.value.http_server_location] : []
    content {
      relative_url = http_server_location.value.relative_url
      path         = http_server_location.value.path
      filename     = http_server_location.value.filename
    }
  }
}

resource "azurerm_data_factory_dataset_postgresql" "this" {
  for_each = var.instance.datasets.postgresql

  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this.id
  linked_service_name = each.value.linked_service_name
  table_name          = each.value.table_name
  description         = each.value.description
  annotations         = each.value.annotations
  parameters          = each.value.parameters
  folder              = each.value.folder
  additional_properties = each.value.additional_properties

  dynamic "schema_column" {
    for_each = lookup(each.value, "schema_column", null) != null ? each.value.schema_column : []
    content {
      name        = schema_column.value.name
      type        = schema_column.value.type
      description = schema_column.value.description
    }
  }
}

resource "azurerm_data_factory_dataset_snowflake" "this" {
  for_each = var.instance.datasets.snowflake

  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this.id
  linked_service_name = each.value.linked_service_name
  schema_name         = each.value.schema_name
  table_name          = each.value.table_name
  description         = each.value.description
  annotations         = each.value.annotations
  parameters          = each.value.parameters
  folder              = each.value.folder
  additional_properties = each.value.additional_properties
}

resource "azurerm_data_factory_dataset_sql_server_table" "this" {
  for_each = var.instance.datasets.sql_server_table

  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this.id
  linked_service_name = each.value.linked_service_name
  table_name          = each.value.table_name
  description         = each.value.description
  annotations         = each.value.annotations
  parameters          = each.value.parameters
  folder              = each.value.folder
  additional_properties = each.value.additional_properties

  dynamic "schema_column" {
    for_each = lookup(each.value, "schema_column", null) != null ? each.value.schema_column : []
    content {
      name        = schema_column.value.name
      type        = schema_column.value.type
      description = schema_column.value.description
    }
  }
}

resource "azurerm_data_factory_custom_dataset" "this" {
  for_each = var.instance.datasets.custom

  name                 = each.value.name
  data_factory_id      = azurerm_data_factory.this.id
  type                 = each.value.type
  type_properties_json = jsonencode(each.value.type_properties)
  description          = each.value.description
  annotations          = each.value.annotations
  parameters           = each.value.parameters
  folder               = each.value.folder
  additional_properties = each.value.additional_properties

  dynamic "linked_service" {
    for_each = lookup(each.value, "linked_service", null) != null ? [each.value.linked_service] : []
    content {
      name       = linked_service.value.name
      parameters = linked_service.value.parameters
    }
  }

  dynamic "schema_column" {
    for_each = lookup(each.value, "schema_column", null) != null ? each.value.schema_column : []
    content {
      name        = schema_column.value.name
      type        = schema_column.value.type
      description = schema_column.value.description
    }
  }
}

# Data Flows
resource "azurerm_data_factory_data_flow" "this" {
  for_each = var.instance.data_flows

  name            = each.value.name
  data_factory_id = azurerm_data_factory.this.id
  description     = each.value.description
  folder          = each.value.folder
  annotations     = each.value.annotations
  script          = each.value.script
  script_lines    = each.value.script_lines

  dynamic "source" {
    for_each = lookup(each.value, "source", null) != null ? each.value.source : []
    content {
      name        = source.value.name
      description = source.value.description

      dynamic "linked_service" {
        for_each = lookup(source.value, "linked_service", null) != null ? [source.value.linked_service] : []
        content {
          name       = linked_service.value.name
          parameters = linked_service.value.parameters
        }
      }

      dynamic "dataset" {
        for_each = lookup(source.value, "dataset", null) != null ? [source.value.dataset] : []
        content {
          name       = dataset.value.name
          parameters = dataset.value.parameters
        }
      }

      dynamic "flowlet" {
        for_each = lookup(source.value, "flowlet", null) != null ? [source.value.flowlet] : []
        content {
          name       = flowlet.value.name
          parameters = flowlet.value.parameters
        }
      }

      dynamic "schema_linked_service" {
        for_each = lookup(source.value, "schema_linked_service", null) != null ? [source.value.schema_linked_service] : []
        content {
          name       = schema_linked_service.value.name
          parameters = schema_linked_service.value.parameters
        }
      }
    }
  }

  dynamic "sink" {
    for_each = lookup(each.value, "sink", null) != null ? each.value.sink : []
    content {
      name        = sink.value.name
      description = sink.value.description

      dynamic "linked_service" {
        for_each = lookup(sink.value, "linked_service", null) != null ? [sink.value.linked_service] : []
        content {
          name       = linked_service.value.name
          parameters = linked_service.value.parameters
        }
      }

      dynamic "dataset" {
        for_each = lookup(sink.value, "dataset", null) != null ? [sink.value.dataset] : []
        content {
          name       = dataset.value.name
          parameters = dataset.value.parameters
        }
      }

      dynamic "flowlet" {
        for_each = lookup(sink.value, "flowlet", null) != null ? [sink.value.flowlet] : []
        content {
          name       = flowlet.value.name
          parameters = flowlet.value.parameters
        }
      }

      dynamic "schema_linked_service" {
        for_each = lookup(sink.value, "schema_linked_service", null) != null ? [sink.value.schema_linked_service] : []
        content {
          name       = schema_linked_service.value.name
          parameters = schema_linked_service.value.parameters
        }
      }
    }
  }

  dynamic "transformation" {
    for_each = lookup(each.value, "transformation", null) != null ? each.value.transformation : []
    content {
      name        = transformation.value.name
      description = transformation.value.description

      dynamic "linked_service" {
        for_each = lookup(transformation.value, "linked_service", null) != null ? [transformation.value.linked_service] : []
        content {
          name       = linked_service.value.name
          parameters = linked_service.value.parameters
        }
      }

      dynamic "dataset" {
        for_each = lookup(transformation.value, "dataset", null) != null ? [transformation.value.dataset] : []
        content {
          name       = dataset.value.name
          parameters = dataset.value.parameters
        }
      }

      dynamic "flowlet" {
        for_each = lookup(transformation.value, "flowlet", null) != null ? [transformation.value.flowlet] : []
        content {
          name       = flowlet.value.name
          parameters = flowlet.value.parameters
        }
      }
    }
  }
}

resource "azurerm_data_factory_flowlet_data_flow" "this" {
  for_each = var.instance.flowlet_data_flows

  name            = each.value.name
  data_factory_id = azurerm_data_factory.this.id
  description     = each.value.description
  folder          = each.value.folder
  annotations     = each.value.annotations
  script          = each.value.script
  script_lines    = each.value.script_lines

  dynamic "source" {
    for_each = lookup(each.value, "source", null) != null ? each.value.source : []
    content {
      name        = source.value.name
      description = source.value.description

      dynamic "linked_service" {
        for_each = lookup(source.value, "linked_service", null) != null ? [source.value.linked_service] : []
        content {
          name       = linked_service.value.name
          parameters = linked_service.value.parameters
        }
      }

      dynamic "dataset" {
        for_each = lookup(source.value, "dataset", null) != null ? [source.value.dataset] : []
        content {
          name       = dataset.value.name
          parameters = dataset.value.parameters
        }
      }
    }
  }

  dynamic "sink" {
    for_each = lookup(each.value, "sink", null) != null ? each.value.sink : []
    content {
      name        = sink.value.name
      description = sink.value.description

      dynamic "linked_service" {
        for_each = lookup(sink.value, "linked_service", null) != null ? [sink.value.linked_service] : []
        content {
          name       = linked_service.value.name
          parameters = linked_service.value.parameters
        }
      }

      dynamic "dataset" {
        for_each = lookup(sink.value, "dataset", null) != null ? [sink.value.dataset] : []
        content {
          name       = dataset.value.name
          parameters = dataset.value.parameters
        }
      }
    }
  }

  dynamic "transformation" {
    for_each = lookup(each.value, "transformation", null) != null ? each.value.transformation : []
    content {
      name        = transformation.value.name
      description = transformation.value.description

      dynamic "linked_service" {
        for_each = lookup(transformation.value, "linked_service", null) != null ? [transformation.value.linked_service] : []
        content {
          name       = linked_service.value.name
          parameters = linked_service.value.parameters
        }
      }

      dynamic "dataset" {
        for_each = lookup(transformation.value, "dataset", null) != null ? [transformation.value.dataset] : []
        content {
          name       = dataset.value.name
          parameters = dataset.value.parameters
        }
      }
    }
  }
}

# Integration Runtimes
resource "azurerm_data_factory_integration_runtime_azure" "this" {
  for_each = var.instance.integration_runtimes.azure

  name                    = each.value.name
  data_factory_id         = azurerm_data_factory.this.id
  location                = each.value.location
  compute_type            = each.value.compute_type
  core_count              = each.value.core_count
  time_to_live_min        = each.value.time_to_live_min
  cleanup_enabled         = each.value.cleanup_enabled
  virtual_network_enabled = each.value.virtual_network_enabled
  description             = each.value.description
}

resource "azurerm_data_factory_integration_runtime_azure_ssis" "this" {
  for_each = var.instance.integration_runtimes.azure_ssis

  name                             = each.value.name
  data_factory_id                  = azurerm_data_factory.this.id
  location                         = each.value.location
  node_size                        = each.value.node_size
  number_of_nodes                  = each.value.number_of_nodes
  edition                          = each.value.edition
  license_type                     = each.value.license_type
  max_parallel_executions_per_node = each.value.max_parallel_executions_per_node
  description                      = each.value.description

  dynamic "vnet_integration" {
    for_each = lookup(each.value, "vnet_integration", null) != null ? [each.value.vnet_integration] : []
    content {
      vnet_id     = vnet_integration.value.vnet_id
      subnet_name = vnet_integration.value.subnet_name
      public_ips  = vnet_integration.value.public_ips
      subnet_id   = vnet_integration.value.subnet_id
    }
  }

  dynamic "catalog_info" {
    for_each = lookup(each.value, "catalog_info", null) != null ? [each.value.catalog_info] : []
    content {
      server_endpoint        = catalog_info.value.server_endpoint
      administrator_login    = catalog_info.value.administrator_login
      administrator_password = catalog_info.value.administrator_password
      pricing_tier           = catalog_info.value.pricing_tier
    }
  }

  dynamic "express_custom_setup" {
    for_each = lookup(each.value, "express_custom_setup", null) != null ? [each.value.express_custom_setup] : []
    content {
      command = express_custom_setup.value.command
    }
  }

  dynamic "proxy" {
    for_each = lookup(each.value, "proxy", null) != null ? [each.value.proxy] : []
    content {
      path                                = proxy.value.path
      staging_storage_linked_service_name = proxy.value.staging_storage_linked_service_name
    }
  }
}

resource "azurerm_data_factory_integration_runtime_self_hosted" "this" {
  for_each = var.instance.integration_runtimes.self_hosted

  name                                       = each.value.name
  data_factory_id                            = azurerm_data_factory.this.id
  description                                = each.value.description
  self_contained_integration_runtime_enabled = each.value.self_contained_integration_runtime_enabled

  dynamic "rbac_authorization" {
    for_each = lookup(each.value, "rbac_authorization_config", null) != null ? [each.value.rbac_authorization_config] : []
    content {
      resource_id = rbac_authorization.value.resource_id
    }
  }
}

# Pipelines
resource "azurerm_data_factory_pipeline" "this" {
  for_each = var.instance.pipelines

  name            = each.value.name
  data_factory_id = azurerm_data_factory.this.id
  description     = each.value.description
  annotations     = each.value.annotations
  activities_json = jsonencode(each.value.activities)
  parameters      = each.value.parameters
  variables       = each.value.variables
  folder          = each.value.folder
}

# Triggers
resource "azurerm_data_factory_trigger_blob_event" "this" {
  for_each = var.instance.triggers.blob_event

  name                  = each.value.name
  data_factory_id       = azurerm_data_factory.this.id
  storage_account_id    = each.value.storage_account_id
  events                = each.value.events
  blob_path_begins_with = each.value.blob_path_begins_with
  blob_path_ends_with   = each.value.blob_path_ends_with
  ignore_empty_blobs    = each.value.ignore_empty_blobs
  description           = each.value.description
  annotations           = each.value.annotations
  activated             = each.value.activated

  dynamic "pipeline" {
    for_each = each.value.pipelines != null ? each.value.pipelines : []
    content {
      name       = pipeline.value.name
      parameters = pipeline.value.parameters != null ? pipeline.value.parameters : {}
    }
  }
}

resource "azurerm_data_factory_trigger_schedule" "this" {
  for_each = var.instance.triggers.schedule

  name            = each.value.name
  data_factory_id = azurerm_data_factory.this.id
  frequency       = each.value.frequency
  interval        = each.value.interval
  start_time      = each.value.start_time
  end_time        = each.value.end_time
  time_zone       = each.value.time_zone
  description     = each.value.description
  annotations     = each.value.annotations
  activated       = each.value.activated

  dynamic "pipeline" {
    for_each = each.value.pipelines != null ? each.value.pipelines : []
    content {
      name       = pipeline.value.name
      parameters = pipeline.value.parameters != null ? pipeline.value.parameters : {}
    }
  }

  dynamic "schedule" {
    for_each = lookup(each.value, "schedule", null) != null ? [each.value.schedule] : []
    content {
      minutes   = schedule.value.minutes
      hours     = schedule.value.hours
      weekdays  = schedule.value.weekdays
      monthdays = schedule.value.monthdays
    }
  }
}

resource "azurerm_data_factory_trigger_tumbling_window" "this" {
  for_each = var.instance.triggers.tumbling_window

  name                  = each.value.name
  data_factory_id       = azurerm_data_factory.this.id
  frequency             = each.value.frequency
  interval              = each.value.interval
  start_time            = each.value.start_time
  end_time              = each.value.end_time
  delay                 = each.value.delay
  max_concurrency       = each.value.max_concurrency
  retry_policy_count    = each.value.retry_policy_count
  retry_policy_interval = each.value.retry_policy_interval
  description           = each.value.description
  annotations           = each.value.annotations
  activated             = each.value.activated

  dynamic "pipeline" {
    for_each = each.value.pipelines != null ? each.value.pipelines : []
    content {
      name       = pipeline.value.name
      parameters = pipeline.value.parameters != null ? pipeline.value.parameters : {}
    }
  }

  dynamic "trigger_dependency" {
    for_each = each.value.trigger_dependencies
    content {
      trigger_name      = trigger_dependency.value.trigger_name
      reference_trigger = trigger_dependency.value.reference_trigger
    }
  }
}

resource "azurerm_data_factory_trigger_custom_event" "this" {
  for_each = var.instance.triggers.custom_event

  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this.id
  eventgrid_topic_id  = each.value.eventgrid_topic_id
  events              = each.value.events
  subject_begins_with = each.value.subject_begins_with
  subject_ends_with   = each.value.subject_ends_with
  description         = each.value.description
  annotations         = each.value.annotations
  activated           = each.value.activated

  dynamic "pipeline" {
    for_each = each.value.pipelines != null ? each.value.pipelines : []
    content {
      name       = pipeline.value.name
      parameters = pipeline.value.parameters != null ? pipeline.value.parameters : {}
    }
  }
}

# Managed Private Endpoint
resource "azurerm_data_factory_managed_private_endpoint" "this" {
  for_each = var.instance.managed_private_endpoints

  name               = each.value.name
  data_factory_id    = azurerm_data_factory.this.id
  target_resource_id = each.value.target_resource_id
  subresource_name   = each.value.subresource_name
  fqdns              = each.value.fqdns
}

# Customer Managed Key
resource "azurerm_data_factory_customer_managed_key" "this" {
  for_each = lookup(var.instance, "customer_managed_key", null) != null ? { "cmk" : var.instance.customer_managed_key } : {}

  data_factory_id              = azurerm_data_factory.this.id
  key_vault_key_id             = each.value.key_vault_key_id
  user_assigned_identity_id    = each.value.user_assigned_identity_id
}
