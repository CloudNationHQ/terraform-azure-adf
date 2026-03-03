variable "instance" {
  description = "describes data factory configuration"
  type = object({
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
        name                 = string
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
        name        = string
        identity_id = string
        description = optional(string)
        annotations = optional(list(string))
      })), {})
    }), {})

    linked_services = optional(object({
      azure_blob_storage = optional(map(object({
        name                     = string
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

        sas_token_linked_key_vault_key = optional(map(object({
          linked_service_name = string
          secret_name         = string
        })), {})
      })), {})

      azure_sql_database = optional(map(object({
        name                     = string
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
        name                     = string
        connection_string        = string
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})

      azure_databricks = optional(map(object({
        name                     = string
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
        name                     = string
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
        name                     = string
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
        name                     = string
        url                      = string
        search_service_key       = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})

      cosmosdb = optional(map(object({
        name                     = string
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
        name                     = string
        connection_string        = string
        database                 = string
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})

      data_lake_storage_gen2 = optional(map(object({
        name                     = string
        url                      = string
        use_managed_identity     = optional(bool)
        storage_account_key      = optional(string)
        service_principal_id     = optional(string)
        service_principal_key    = optional(string)
        tenant_id                = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})

      key_vault = optional(map(object({
        name                     = string
        key_vault_id             = string
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})

      kusto = optional(map(object({
        name                     = string
        kusto_endpoint           = string
        kusto_database_name      = string
        use_managed_identity     = optional(bool)
        service_principal_id     = optional(string)
        service_principal_key    = optional(string)
        tenant_id                = optional(string)
        description              = optional(string)
        integration_runtime_name = optional(string)
        annotations              = optional(list(string))
        parameters               = optional(map(string))
        additional_properties    = optional(map(string))
      })), {})

      mysql = optional(map(object({
        name                     = string
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

      odata = optional(map(object({
        name                     = string
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
        name                     = string
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
        name                     = string
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

      sftp = optional(map(object({
        name                     = string
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
      })), {})

      snowflake = optional(map(object({
        name                     = string
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
        name                     = string
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

      sql_server = optional(map(object({
        name                     = string
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

      synapse = optional(map(object({
        name                     = string
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
        name                     = string
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
        name                  = string
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
        name                  = string
        linked_service_name   = string
        path                  = optional(string)
        filename              = optional(string)
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

      azure_sql_table = optional(map(object({
        name                  = string
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

      binary = optional(map(object({
        name                  = string
        linked_service_name   = string
        folder                = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        additional_properties = optional(map(string))

        azure_blob_storage_location = optional(object({
          container = string
          path      = optional(string)
          filename  = optional(string)
        }))

        http_server_location = optional(object({
          relative_url = string
          path         = optional(string)
          filename     = optional(string)
        }))

        sftp_server_location = optional(object({
          path     = string
          filename = optional(string)
        }))

        compression = optional(object({
          type = string
        }))
      })), {})

      cosmosdb_sqlapi = optional(map(object({
        name                  = string
        linked_service_name   = string
        collection_name       = string
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))
      })), {})

      delimited_text = optional(map(object({
        name                  = string
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
          container = string
          path      = optional(string)
          filename  = optional(string)
        }))

        http_server_location = optional(object({
          relative_url = string
          path         = optional(string)
          filename     = optional(string)
        }))

        azure_blob_fs_location = optional(object({
          file_system = string
          path        = optional(string)
          filename    = optional(string)
        }))
      })), {})

      http = optional(map(object({
        name                  = string
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
        name                  = string
        linked_service_name   = string
        encoding              = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))

        azure_blob_storage_location = optional(object({
          container = string
          path      = optional(string)
          filename  = optional(string)
        }))

        http_server_location = optional(object({
          relative_url = string
          path         = optional(string)
          filename     = optional(string)
        }))
      })), {})

      mysql = optional(map(object({
        name                  = string
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
        name                  = string
        linked_service_name   = string
        compression_codec     = optional(string)
        compression_level     = optional(string)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))

        azure_blob_storage_location = optional(object({
          container = string
          path      = optional(string)
          filename  = optional(string)
        }))

        http_server_location = optional(object({
          relative_url = string
          path         = optional(string)
          filename     = optional(string)
        }))
      })), {})

      postgresql = optional(map(object({
        name                  = string
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
        name                  = string
        linked_service_name   = string
        schema_name           = string
        table_name            = string
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))
      })), {})

      sql_server_table = optional(map(object({
        name                  = string
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
        name                  = string
        type                  = string
        type_properties       = map(any)
        description           = optional(string)
        annotations           = optional(list(string))
        parameters            = optional(map(string))
        folder                = optional(string)
        additional_properties = optional(map(string))

        linked_service = optional(object({
          name       = string
          parameters = optional(map(string))
        }))

        schema_column = optional(list(object({
          name        = string
          type        = optional(string)
          description = optional(string)
        })))
      })), {})
    }), {})

    data_flows = optional(map(object({
      name         = string
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
          name       = string
          parameters = optional(map(string))
        }))

        schema_linked_service = optional(object({
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
          name       = string
          parameters = optional(map(string))
        }))

        schema_linked_service = optional(object({
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
          name       = string
          parameters = optional(map(string))
        }))
      })))
    })), {})

    flowlet_data_flows = optional(map(object({
      name         = string
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
      })))
    })), {})

    integration_runtimes = optional(object({
      azure = optional(map(object({
        name                    = string
        location                = string
        compute_type            = optional(string)
        core_count              = optional(number)
        time_to_live_min        = optional(number)
        cleanup_enabled         = optional(bool)
        virtual_network_enabled = optional(bool)
        description             = optional(string)
      })), {})

      azure_ssis = optional(map(object({
        name                             = string
        location                         = string
        node_size                        = string
        number_of_nodes                  = optional(number)
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
        }))

        express_custom_setup = optional(object({
          command = string
        }))

        proxy = optional(object({
          path                                = string
          staging_storage_linked_service_name = string
        }))
      })), {})

      self_hosted = optional(map(object({
        name                                       = string
        description                                = optional(string)
        self_contained_integration_runtime_enabled = optional(bool)

        rbac_authorization_config = optional(object({
          resource_id = string
        }))
      })), {})
    }), {})

    pipelines = optional(map(object({
      name        = string
      activities  = list(map(any))
      description = optional(string)
      annotations = optional(list(string))
      parameters  = optional(map(string))
      variables   = optional(map(string))
      folder      = optional(string)
    })), {})

    triggers = optional(object({
      blob_event = optional(map(object({
        name                  = string
        storage_account_id    = string
        events                = list(string)
        blob_path_begins_with = optional(string)
        blob_path_ends_with   = optional(string)
        ignore_empty_blobs    = optional(bool)
        description           = optional(string)
        annotations           = optional(list(string))
        activated             = optional(bool)

        pipelines = optional(list(object({
          name       = string
          parameters = optional(map(string))
        })))
      })), {})

      schedule = optional(map(object({
        name        = string
        frequency   = string
        interval    = number
        start_time  = optional(string)
        end_time    = optional(string)
        time_zone   = optional(string)
        description = optional(string)
        annotations = optional(list(string))
        activated   = optional(bool)

        pipelines = optional(list(object({
          name       = string
          parameters = optional(map(string))
        })))

        schedule = optional(object({
          minutes   = optional(list(number))
          hours     = optional(list(number))
          weekdays  = optional(list(string))
          monthdays = optional(list(number))
        }))
      })), {})

      tumbling_window = optional(map(object({
        name                  = string
        frequency             = string
        interval              = number
        start_time            = string
        end_time              = optional(string)
        delay                 = optional(string)
        max_concurrency       = optional(number)
        retry_policy_count    = optional(number)
        retry_policy_interval = optional(number)
        description           = optional(string)
        annotations           = optional(list(string))
        activated             = optional(bool)

        pipelines = optional(list(object({
          name       = string
          parameters = optional(map(string))
        })))

        trigger_dependencies = optional(list(object({
          trigger_name      = string
          reference_trigger = optional(string)
        })))
      })), {})

      custom_event = optional(map(object({
        name                = string
        eventgrid_topic_id  = string
        events              = list(string)
        subject_begins_with = optional(string)
        subject_ends_with   = optional(string)
        description         = optional(string)
        annotations         = optional(list(string))
        activated           = optional(bool)

        pipelines = optional(list(object({
          name       = string
          parameters = optional(map(string))
        })))
      })), {})
    }), {})

    managed_private_endpoints = optional(map(object({
      name               = string
      target_resource_id = string
      subresource_name   = string
      fqdns              = optional(list(string))
    })), {})

    customer_managed_key = optional(object({
      key_vault_key_id          = string
      user_assigned_identity_id = optional(string)
    }))
  })
}

variable "naming" {
  description = "contains naming convention"
  type = object({
  })
  default = {}
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
