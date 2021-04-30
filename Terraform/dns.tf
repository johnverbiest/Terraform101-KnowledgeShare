variable "dnsResourceGroupName" {
  type        = string
  default     = "personal"
  description = "Dns Resource Group Name"
}

variable "dnsZoneName" {
  type        = string
  default     = "masterofdisaster.be"
  description = "Dns Zone Name"
}

variable "dnsEntry" {
  type        = string
  default     = "awesomewebsite"
  description = "Dns Name"
}

resource "azurerm_dns_cname_record" "webDnsEntry" {
  name                = "${var.dnsEntry}${local.resource_postfix}"
  zone_name           = var.dnsZoneName
  resource_group_name = var.dnsResourceGroupName
  ttl                 = 300
  record              = azurerm_app_service.awesomeTfDemo.default_site_hostname
}
