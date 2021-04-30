terraform {
  backend "azurerm" {
    resource_group_name = "demoTerraformBackend"
    storage_account_name = "demoterraformbackendien6"
    container_name = "terraform-state"
    key = "TerraformDemo"
  }
}

provider "azurerm" {
  features {}
}

