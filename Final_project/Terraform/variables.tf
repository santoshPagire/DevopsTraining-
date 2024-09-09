variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "sp-new-cap-bucket01"
}

variable "bucket_acl" {
  description = "The ACL for the S3 bucket"
  type        = string
  default     = "private"
}

variable "versioning_enabled" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "sse_algorithm" {
  description = "The server-side encryption algorithm to use"
  type        = string
  default     = "AES256"
}

variable "instance_type" {
  description = "Type of the EC2 instance (e.g., t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Type of the EC2 instance (e.g., t2.micro)"
  type        = string
  default     = "SP_instance"
}

variable "container_port" {
  description = "The port on which the container is running"
  type        = number
  default     = 80
}

variable "environment" {
  description = "The port on which the container is running"
  type        = string
  default     = "Dev"
}

variable "ami" {
  description = "The port on which the container is running"
  type        = string
  default     = "ami-085f9c64a9b75eed5"
}

variable "instance_type_1" {
  description = "The port on which the container is running"
  type        = string
  default     = "t2.medium"
}

variable "instance_type_2" {
  description = "The port on which the container is running"
  type        = string
  default     = "t2.micro"
}

variable "instance_name_1" {
  description = "The port on which the container is running"
  type        = string
  default     = "SP_ControlPlane"
}

variable "instance_name_2" {
  description = "The port on which the container is running"
  type        = string
  default     = "SP_DataPlane_1"
}

variable "instance_name_3" {
  description = "The port on which the container is running"
  type        = string
  default     = "SP_DataPlane_2"
}