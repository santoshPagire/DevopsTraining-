variable "name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "SpService12"
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "task_family_name" {
  description = "The name of the ECS task family"
  type        = string
}

variable "container_image" {
  description = "The Docker image to be used"
  type        = string
}

variable "container_port" {
  description = "The port on which the container listens"
  type        = number
}

variable "container_environment" {
  description = "Environment variables for the container"
  type        = list(map(string))
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "alb_security_group_id" {
  description = "The security group ID for the ALB"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "The public subnets to use"
  type        = list(string)
}