resource "random_password" "sqlPassword" {
  length = 128
  min_lower = 1
  min_numeric = 1
  min_special = 1
  min_upper = 1
  keepers = {
    time = timestamp()
  }
}

resource "random_string" "sqlUser" {
  length = 15
  number = false
  special = false
  upper = false
}

variable "sqlVersion" {
  type = string
  default = "12.0"
}

resource "azurerm_sql_server" "sqlServer" {
  name                         = substr(lower("${var.productName}${local.resource_postfix}-sql"), 0, 63)
  resource_group_name          = azurerm_resource_group.awesomeTfDemo.name
  location                     = azurerm_resource_group.awesomeTfDemo.location
  version                      = var.sqlVersion
  administrator_login          = random_string.sqlUser.result
  administrator_login_password = random_password.sqlPassword.result

  tags = {
    Provider = "Terraform"
    File = "sql.tf"
    Repository = "Terraform101-KnowledgeShare"
    Environment = local.environment
  }
}




variable "sqlEdition" {
  type = string
  default = "Basic"
}

variable "databaseName" {
  type = string
  default = "AwesomeDatabase"
}

resource "azurerm_sql_database" "AwesomeDatabase" {
  name                = var.databaseName
  resource_group_name = azurerm_resource_group.awesomeTfDemo.name
  location            = azurerm_resource_group.awesomeTfDemo.location
  server_name         = azurerm_sql_server.sqlServer.name
  edition             = var.sqlEdition

  tags = {
    Provider = "Terraform"
    File = "sql.tf"
    Repository = "Terraform101-KnowledgeShare"
    Environment = local.environment
  }
}
