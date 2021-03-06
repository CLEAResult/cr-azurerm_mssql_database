output "database_name" {
  description = "Database name of the Azure SQL Database created."
  value       = azurerm_sql_database.db.*.name
}

output "id" {
  description = "The SQL Database ID."
  value       = azurerm_sql_database.db.*.id
}

output "creation_date" {
  description = "The creation date of the SQL Database."
  value       = azurerm_sql_database.db.*.creation_date
}

output "default_secondary_location" {
  description = "The default secondary location of the SQL Database."
  value       = azurerm_sql_database.db.*.default_secondary_location
}

output "connection_string" {
  description = <<EOF
Connection string for the Azure SQL Database created. Demands a managed service identity (MSI) on the resource caling the database, so username/password are not required.
EOF
  value       = format("%s%s", local.cs_prefix, azurerm_sql_database.db.*.name[0])
}

