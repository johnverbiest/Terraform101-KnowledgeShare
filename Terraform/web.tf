variable "appServicePlanTier" {
  type = string
  default = "Standard"
}

variable "appServicePlanSize" {
  type = string
  default = "S1"
}

resource "azurerm_app_service_plan" "awesomeTfDemo" {
  name = "${var.productName}${local.resource_postfix}-asp"
  location = azurerm_resource_group.awesomeTfDemo.location
  resource_group_name = azurerm_resource_group.awesomeTfDemo.name

  sku {
    tier = var.appServicePlanTier
    size = var.appServicePlanSize
  }

  tags = {
    Provider = "Terraform"
    File = "web.tf"
    Repository = "Terraform101-KnowledgeShare"
    Environment = local.environment
  }
}

resource "azurerm_app_service" "awesomeTfDemo" {
  name = "${var.productName}${local.resource_postfix}-web"
  location = azurerm_resource_group.awesomeTfDemo.location
  resource_group_name = azurerm_resource_group.awesomeTfDemo.name
  app_service_plan_id = azurerm_app_service_plan.awesomeTfDemo.id

  site_config {
    dotnet_framework_version = "v5.0"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"         = azurerm_application_insights.website.instrumentation_key
    "ApplicationInsights.InstrumentationKey" = azurerm_application_insights.website.instrumentation_key
    "storageAccount"                         = azurerm_storage_account.logStorage.primary_connection_string
    "APPINSIGHTS_PORTALINFO"                 = "ASP.NET"
    "APPINSIGHTS_PROFILERFEATURE_VERSION"    = "1.0.0"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=${azurerm_sql_server.sqlServer.fully_qualified_domain_name};Database=${azurerm_sql_database.AwesomeDatabase.name};User Id=${random_string.sqlUser.result};Password=${random_password.sqlPassword.result}"
  }

  tags = {
    Provider = "Terraform"
    File = "web.tf"
    Repository = "Terraform101-KnowledgeShare"
    Environment = local.environment
  }
}


resource "azurerm_app_service_custom_hostname_binding" "awesomeTfDemo" {
  hostname            = trim(azurerm_dns_cname_record.webDnsEntry.fqdn, ".")
  app_service_name    = azurerm_app_service.awesomeTfDemo.name
  resource_group_name = azurerm_resource_group.awesomeTfDemo.name
  lifecycle {
    ignore_changes = [ssl_state, thumbprint]
  }
}
