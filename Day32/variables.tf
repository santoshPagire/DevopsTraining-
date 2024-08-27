variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "The list of public subnets CIDR blocks"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

variable "private_subnets" {
  description = "The list of private subnets CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"] 
}

variable "availability_zones" {
  description = "The list of availability zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}

variable "name" {
  description = "The name prefix for resources"
  type        = string
  default     = "sp"
}

variable "environment" {
  description = "The environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "container_port" {
  description = "The port on which the container is running"
  type        = number
  default     = 80
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "mynew_Cluster"
}

variable "task_family_name" {
  description = "The name of the ECS task family"
  type        = string
  default     = "mynew_Cluster"
}

variable "container_image" {
  description = "The Docker image to be used"
  type        = string
  default     = "Sp_Image"

}

variable "container_environment" {
  description = "The environment variables for the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = [
    {
      name  = "ENVIRONMENT"
      value = "Dev"
    }
  ]
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
  default     = "my_ECS"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default = "sp-ecs-db"
}

variable "db_username" {
  description = "The username for the database"
  type        = string
  default = "admin"
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  default = "MySecurePassword123!"
}

