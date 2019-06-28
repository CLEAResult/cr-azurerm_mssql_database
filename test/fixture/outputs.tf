output "sql_server_fqdn" {
  value = module.sql-server.sql_server_fqdn
}

output "database_name" {
  value = module.sql-database.database_name
}

output "id" {
  value = module.sql-database.id
}

output "creation_date" {
  value = module.sql-database.creation_date
}

output "default_secondary_location" {
  value = module.sql-database.default_secondary_location
}

output "connection_string" {
  value = module.sql-database.connection_string
}
