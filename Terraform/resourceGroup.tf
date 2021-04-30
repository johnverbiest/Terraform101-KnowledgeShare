variable "resourceGroupName" {
  type        = string
  default     = "AwesomeTfDemo"
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "Azure Location"
}

resource "azurerm_resource_group" "InvoiceApi" {
  name     = var.resourceGroupName
  location = var.location
  tags     = {
    Provider = "Terraform"
    File = "resourceGroup.tf"
    Repository = "Terraform101-KnowledgeShare"
  }
}
