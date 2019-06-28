variable "rgid" {
  default = "00000"
}

variable "resource_group_name" {
  default = "mssqlDatabase"
}

variable "location" {
  default = "westus2"
}

variable "sql_admin_username" {
  default = "azureuser"
}

variable "sql_admin_password" {
  default = "P@ssw0rd12345!"
}

variable "start_ip_address" {
  default = "0.0.0.0"
}

variable "end_ip_address" {
  default = "255.255.255.255"
}

