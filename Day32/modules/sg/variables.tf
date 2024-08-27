variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "container_port" {
  description = "The port on which the container is running"
  type        = number
}

variable "name" {
  description = "The name prefix for resources"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, prod)"
  type        = string
}
