locals {
  _linked_services_by_type = {
    azure_blob_storage = {
      entries = var.instance.linked_services.azure_blob_storage, abbreviation = "lsabs"
    }
    azure_databricks = {
      entries = var.instance.linked_services.azure_databricks, abbreviation = "lsadb"
    }
    azure_file_storage = {
      entries = var.instance.linked_services.azure_file_storage, abbreviation = "lsafs"
    }
    azure_function = {
      entries = var.instance.linked_services.azure_function, abbreviation = "lsaf"
    }
    azure_search = {
      entries = var.instance.linked_services.azure_search, abbreviation = "lsas"
    }
    azure_sql_database = {
      entries = var.instance.linked_services.azure_sql_database, abbreviation = "lsasql"
    }
    azure_table_storage = {
      entries = var.instance.linked_services.azure_table_storage, abbreviation = "lsats"
    }
    cosmosdb = {
      entries = var.instance.linked_services.cosmosdb, abbreviation = "lscdb"
    }
    cosmosdb_mongoapi = {
      entries = var.instance.linked_services.cosmosdb_mongoapi, abbreviation = "lscdbm"
    }
    data_lake_storage_gen2 = {
      entries = var.instance.linked_services.data_lake_storage_gen2, abbreviation = "lsdls"
    }
    key_vault = {
      entries = var.instance.linked_services.key_vault, abbreviation = "lskv"
    }
    kusto = {
      entries = var.instance.linked_services.kusto, abbreviation = "lsku"
    }
    mysql = {
      entries = var.instance.linked_services.mysql, abbreviation = "lsmy"
    }
    odata = {
      entries = var.instance.linked_services.odata, abbreviation = "lsod"
    }
    odbc = {
      entries = var.instance.linked_services.odbc, abbreviation = "lsobc"
    }
    postgresql = {
      entries = var.instance.linked_services.postgresql, abbreviation = "lspg"
    }
    sftp = {
      entries = var.instance.linked_services.sftp, abbreviation = "lssftp"
    }
    snowflake = {
      entries = var.instance.linked_services.snowflake, abbreviation = "lssf"
    }
    sql_managed_instance = {
      entries = var.instance.linked_services.sql_managed_instance, abbreviation = "lssmi"
    }
    sql_server = {
      entries = var.instance.linked_services.sql_server, abbreviation = "lssql"
    }
    synapse = {
      entries = var.instance.linked_services.synapse, abbreviation = "lssyn"
    }
    web = {
      entries = var.instance.linked_services.web, abbreviation = "lsw"
    }
    custom = {
      entries = var.instance.linked_services.custom, abbreviation = "lsc"
    }
  }

  linked_services_name_map = merge(flatten([
    for type, config in local._linked_services_by_type : [
      { for k, v in config.entries : k => coalesce(v.name, "${config.abbreviation}-${k}") }
    ]
  ])...)

  _datasets_by_type = {
    azure_blob = {
      entries = var.instance.datasets.azure_blob, abbreviation = "dsab"
    }
    azure_sql_table = {
      entries = var.instance.datasets.azure_sql_table, abbreviation = "dsasql"
    }
    binary = {
      entries = var.instance.datasets.binary, abbreviation = "dsbin"
    }
    cosmosdb_sqlapi = {
      entries = var.instance.datasets.cosmosdb_sqlapi, abbreviation = "dscdb"
    }
    delimited_text = {
      entries = var.instance.datasets.delimited_text, abbreviation = "dsdt"
    }
    http = {
      entries = var.instance.datasets.http, abbreviation = "dshttp"
    }
    json = {
      entries = var.instance.datasets.json, abbreviation = "dsjson"
    }
    mysql = {
      entries = var.instance.datasets.mysql, abbreviation = "dsmy"
    }
    parquet = {
      entries = var.instance.datasets.parquet, abbreviation = "dspq"
    }
    postgresql = {
      entries = var.instance.datasets.postgresql, abbreviation = "dspg"
    }
    snowflake = {
      entries = var.instance.datasets.snowflake, abbreviation = "dssf"
    }
    sql_server_table = {
      entries = var.instance.datasets.sql_server_table, abbreviation = "dssql"
    }
    custom = {
      entries = var.instance.datasets.custom, abbreviation = "dsc"
    }
  }

  datasets_name_map = merge(flatten([
    for type, config in local._datasets_by_type : [
      { for k, v in config.entries : k => coalesce(v.name, "${config.abbreviation}-${k}") }
    ]
  ])...)

  _integration_runtimes_by_type = {
    azure = {
      entries = var.instance.integration_runtimes.azure, abbreviation = "ira"
    }
    azure_ssis = {
      entries = var.instance.integration_runtimes.azure_ssis, abbreviation = "iras"
    }
    self_hosted = {
      entries = var.instance.integration_runtimes.self_hosted, abbreviation = "irsh"
    }
  }

  integration_runtimes_name_map = merge(flatten([
    for type, config in local._integration_runtimes_by_type : [
      { for k, v in config.entries : k => coalesce(v.name, "${config.abbreviation}-${k}") }
    ]
  ])...)

  _credentials_by_type = {
    service_principal = {
      entries = var.instance.credentials.service_principal, abbreviation = "csp"
    }
    user_managed_identity = {
      entries = var.instance.credentials.user_managed_identity, abbreviation = "cumi"
    }
  }

  credentials_name_map = merge(flatten([
    for type, config in local._credentials_by_type : [
      { for k, v in config.entries : k => coalesce(v.name, "${config.abbreviation}-${k}") }
    ]
  ])...)
}
