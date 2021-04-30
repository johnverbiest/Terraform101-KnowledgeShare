# Name max lenght = 15 and needs to be unique globally, so we cannot follow convention here

resource "random_string" "storagePreFix" {
  length = 5
  special = false
  number = false
}

locals {
  storageName =  lower(substr(replace("${random_string.storagePreFix.result}${local.resource_postfix}${var.productName}-storage", "-", ""), 0, 15))
}


variable "logStorageTier" {
  type = string
  default = "Standard"
}

variable "logStorageReplication" {
  type = string
  default = "GRS"
}

resource "azurerm_storage_account" "logStorage" {
  name                     = local.storageName
  resource_group_name      = azurerm_resource_group.awesomeTfDemo.name
  location                 = azurerm_resource_group.awesomeTfDemo.location
  account_tier             = var.logStorageTier
  account_replication_type = var.logStorageReplication

  tags = {
    Provider = "Terraform"
    File = "storageAccount.tf"
    Repository = "Terraform101-KnowledgeShare"
    Environment = local.environment
  }
}
