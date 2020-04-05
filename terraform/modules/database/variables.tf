variable "environment" {
  description = "Environment"
}
variable "suffix" {
  description = "Change the resource name according to the environment"  
}
variable "username" {
    default = "postgre"
}
variable "password" {
  default = "p4ssw0rd1234"
}
variable "database_name" {
  default = "serverlessappdatabase"
}
locals {
  cleansuffix = "${replace(lower(var.suffix),"/[^a-z]/", "")}"
}
variable "engine" {
  default = "aurora-postgresql"
}
variable "host" {
  default = "value"
}
variable "port" {
  default = 5432
}
variable "dbInstanceIdentifier" {
  default = "serverlessapp-db"
}