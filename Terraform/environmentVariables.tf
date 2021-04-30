variable "productName" {
  type = string
  default = "AwesomeTfDemo"
  description = "Product Name"
}

locals {
  environment      = terraform.workspace == "prod" ? "production" : "dev"
  resource_postfix = terraform.workspace == "prod" ? "" : "-dev"
}
