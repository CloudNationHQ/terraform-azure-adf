# Default

This example illustrates the default setup, in its simplest form.

## Usage

```hcl
module "adf" {
  source  = "cloudnationhq/adf/azure"
  version = "~> 0.1"

  instance = {
    name                = "adf-demo-dev"
    location            = "westeurope"
    resource_group_name = "rg-demo-dev"

    identity = {
      type = "SystemAssigned"
    }
  }
}
```
