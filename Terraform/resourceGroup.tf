variable "location" {
  type        = string
  default     = "westeurope"
  description = "Azure Location"
}

resource "azurerm_resource_group" "awesomeTfDemo" {
  name     = "${var.productName}${local.resource_postfix}"
  location = var.location
  tags     = {
    Provider = "Terraform"
    File = "resourceGroup.tf"
    Repository = "Terraform101-KnowledgeShare"
  }
}
