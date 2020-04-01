resource "azurerm_sql_database" "db" {
  name                             = local.names.override != "" ? local.names.override : format("%s%03d%s", local.names.db, count.index + 1, local.names.suffix)
  count                            = var.num
  resource_group_name              = var.rg_name
  location                         = var.location
  edition                          = var.db_edition
  collation                        = var.collation
  server_name                      = var.server_name
  create_mode                      = var.create_mode
  requested_service_objective_name = var.service_objective_name

  tags = {
    InfrastructureAsCode = "True"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azuread_group" "read_group" {
  name = format("g%s%s%s_NA_Read", local.default_rgid, local.env_id, local.type)
}

resource "azuread_group" "rwx_group" {
  name = format("g%s%s%s_NA_ReadWriteExec", local.default_rgid, local.env_id, local.type)
}

resource "azuread_group" "owner_group" {
  name = format("g%s%s%s_NA_Owner", local.default_rgid, local.env_id, local.type)
}

data "azurerm_subscription" "primary" {}
