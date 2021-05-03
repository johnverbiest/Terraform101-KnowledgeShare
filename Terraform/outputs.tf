output "sqlServer" {
  value = azurerm_sql_server.sqlServer.fully_qualified_domain_name
}
output "sqlAdmin" {
  value = azurerm_sql_server.sqlServer.administrator_login
}
output "sqlPassword" {
  value = azurerm_sql_server.sqlServer.administrator_login_password
  sensitive = true
}
output "webAppName" {
  value = azurerm_app_service.awesomeTfDemo.name
}
