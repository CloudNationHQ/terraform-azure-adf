locals {
  linked_services_name_map = merge([
    for entries in values(var.instance.linked_services) : {
      for k, v in entries : k => coalesce(v.name, k)
    }
  ]...)

  datasets_name_map = merge([
    for entries in values(var.instance.datasets) : {
      for k, v in entries : k => coalesce(v.name, k)
    }
  ]...)

  integration_runtimes_name_map = merge([
    for entries in values(var.instance.integration_runtimes) : {
      for k, v in entries : k => coalesce(v.name, k)
    }
  ]...)

  credentials_name_map = merge([
    for entries in values(var.instance.credentials) : {
      for k, v in entries : k => coalesce(v.name, k)
    }
  ]...)

  pipelines_name_map = {
    for k, v in var.instance.pipelines : k => coalesce(v.name, k)
  }
}
