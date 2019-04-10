variable "rgid" {
  description = "RGID used for naming"
}
variable "location" {
  default = "southcentralus"
  description = "Location for resources to be created"
}

variable "count" {
 default = "1"
}

variable "name_prefix" {
  default = ""
  description = "Allows users to override the standard naming prefix.  If left as an empty string, the standard naming conventions will apply."
}

variable "environment" {
  default = "dev"
  description = "Environment used in naming lookups"
}


variable "rg_name" {
  description = "Default resource group name that the database will be created in."
}

variable "db_edition" {
  description = "The edition of the database to be created. Applies only if create_mode is Default. Valid values are: Basic, Standard, Premium, or DataWarehouse."
  default     = "Basic"
}

variable "service_objective_name" {
  description = "The performance level for the database. For the list of acceptable values, see https://docs.microsoft.com/en-gb/azure/sql-database/sql-database-service-tiers. Default is Basic."
  default     = "Basic"
}

variable "collation" {
  description = "The collation for the database. Default is SQL_Latin1_General_CP1_CI_AS"
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "create_mode" {
  default = "Default"
}

variable "server_name" {
  description = "Azure SQL server where the database will be created."
}


# Compute default name values
locals {
  env_id              = "${lookup(module.naming.env-map, var.environment, "ENV")}"
  type                = "${lookup(module.naming.type-map, "azurerm_sql_database", "TYP")}"

  default_rgid        = "${var.rgid != "" ? var.rgid : "NORGID"}"
  default_name_prefix = "c${local.default_rgid}${local.env_id}"

  name_prefix         = "${var.name_prefix != "" ? var.name_prefix : local.default_name_prefix}"
  name                = "${local.name_prefix}${local.type}"
}

# This module provides a data map output to lookup naming standard references
module "naming" {
  source = "git::ssh://git@github.com/clearesult/cr-azurerm-naming.git?ref=v1.0"
}
