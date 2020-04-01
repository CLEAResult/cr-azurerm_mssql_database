provider "random" {
  version = "~> 2.1"
}

resource "random_id" "name" {
  byte_length = 8
}

resource "azurerm_resource_group" "rg" {
  name     = format("%s-%s", var.resource_group_name, random_id.name.hex)
  location = var.location
}

module "sql-server" {
  source             = "git::https://github.com/clearesult/cr-azurerm_mssql_server.git?ref=v1.4.3"
  rgid               = var.rgid
  rg_name            = basename(azurerm_resource_group.rg.id)
  location           = var.location
  sql_admin_username = var.sql_admin_username
  sql_admin_password = var.sql_admin_password
}

module "sql-database" {
  source      = "../../"
  rgid        = var.rgid
  rg_name     = basename(azurerm_resource_group.rg.id)
  location    = var.location
  server_name = basename(module.sql-server.sql_server_id[0])
  name_prefix = format("test%s", var.rgid)
  name_suffix = "testdb"
}

module "sql-database2" {
  source        = "../../"
  rgid          = var.rgid
  rg_name       = basename(azurerm_resource_group.rg.id)
  location      = var.location
  server_name   = basename(module.sql-server.sql_server_id[0])
  name_override = format("override%s", random_id.name.hex)
}

