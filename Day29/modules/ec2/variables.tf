variable "ami_id" {
  type        = string
  description = "The AMI ID to use for the instance"
}

variable "instance_type" {
  type        = string
  description = "The instance type for the EC2 instance"
}

variable "instance_name" {
  type        = string
  description = "The name of the EC2 instance"
}
