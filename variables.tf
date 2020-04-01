variable "rgid" {
  type        = string
  description = "RGID used for naming"
}

variable "location" {
  type        = string
  default     = "southcentralus"
  description = "Location for resources to be created"
}

variable "num" {
  type    = number
  default = 1
}

variable "name_prefix" {
  type        = string
  default     = ""
  description = "Allows users to override the standard naming prefix.  If left as an empty string, the standard naming conventions will apply."
}

variable "name_suffix" {
  type        = string
  default     = ""
  description = "Allows users to override the standard naming suffix, appearing after the instance count.  If left as an empty string, the standard naming conventions will apply."
}

variable "name_override" {
  type        = string
  default     = ""
  description = "If non-empty, will override all the standard naming conventions.  This should only be used when a product requires a specific database name."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment used in naming lookups"
}

variable "rg_name" {
  type        = string
  description = "Default resource group name that the database will be created in."
}

variable "db_edition" {
  type        = string
  default     = "Basic"
  description = "The edition of the database to be created. Applies only if create_mode is Default. Valid values are: Basic, Standard, Premium, or DataWarehouse."
}

variable "service_objective_name" {
  type        = string
  default     = "Basic"
  description = "The performance level for the database. For the list of acceptable values, see https://docs.microsoft.com/en-gb/azure/sql-database/sql-database-service-tiers. Default is Basic."
}

variable "collation" {
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
  description = "The collation for the database. Default is SQL_Latin1_General_CP1_CI_AS"
}

variable "create_mode" {
  type    = string
  default = "Default"
}

variable "server_name" {
  type        = string
  description = "Azure SQL server where the database will be created."
}

# Compute default name values
locals {
  env_id = lookup(module.naming.env-map, var.environment, "env")
  type   = lookup(module.naming.type-map, "azurerm_sql_database", "typ")

  default_rgid        = var.rgid != "" ? var.rgid : "norgid"
  default_name_prefix = format("c%s%s", local.default_rgid, local.env_id)

  name_prefix = var.name_prefix != "" ? var.name_prefix : local.default_name_prefix

  names = {
    db       = format("%s%s", local.name_prefix, local.type)
    suffix   = var.name_suffix
    override = var.name_override
  }

  # This variable eases the problem of having a multi-line interpolated string for the 
  # connection string output
  cs_prefix = format("Server=tcp:%s.database.windows.net,1433;Database=", var.server_name)
}

# This module provides a data map output to lookup naming standard references
module "naming" {
  source = "git::https://github.com/clearesult/cr-azurerm-naming.git?ref=v1.1.2"
}

