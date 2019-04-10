resource "azurerm_sql_database" "db" {
  name                             = "${local.name}${format("%3d", count.index)}"
  count                            = "${var.count}"
  resource_group_name              = "${var.rg_name}"
  location                         = "${var.location}"
  edition                          = "${var.db_edition}"
  collation                        = "${var.collation}"
  server_name                      = "${var.server_name}"
  create_mode                      = "${var.create_mode}"
  requested_service_objective_name = "${var.service_objective_name}"

  tags = {
    InfrastructureAsCode = "True"
  }

  lifecycle {
    ignore_changes = ["tags"]
  }
}
