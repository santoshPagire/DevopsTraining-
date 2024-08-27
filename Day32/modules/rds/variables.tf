variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "Sp_DB"
}

variable "db_username" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
}

variable "vpc_security_group_id" {
  description = "The VPC security group ID"
  type        = string
}

variable "private_subnets" {
  description = "The private subnets to use"
  type        = list(string)
}

variable "db_subnet_group_name" {
  type        = string
  default     = "my_subnet_group"
}