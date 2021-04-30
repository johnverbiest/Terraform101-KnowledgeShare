
resource "azurerm_application_insights" "website" {
  name                = "${var.productName}${local.resource_postfix}-ai"
  location            = azurerm_resource_group.awesomeTfDemo.location
  resource_group_name = azurerm_resource_group.awesomeTfDemo.name
  application_type    = "web"
}
