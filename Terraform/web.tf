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

  tags = {
    Provider = "Terraform"
    File = "web.tf"
    Repository = "Terraform101-KnowledgeShare"
  }
}
