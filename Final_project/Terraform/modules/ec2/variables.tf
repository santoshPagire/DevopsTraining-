variable "ami" {
  description = "AMI to be used for the instance"
  type        = string
  default     = "ami-085f9c64a9b75eed5"
}

variable "instance_type_1" {
  description = "Type of the instance (e.g., t2.micro)"
  type        = string
  default     = "t2.medium"
}

variable "instance_type_2" {
  description = "List of security group IDs to assign to the instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key to use"
  type        = string
  default = "Mynewkey"
  
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be placed"
  type        = string
}

variable "instance_name_1" {
  description = "Subnet ID where the instance will be placed"
  type        = string
  
}

variable "instance_name_2" {
  description = "Subnet ID where the instance will be placed"
  type        = string
  
}

variable "instance_name_3" {
  description = "Subnet ID where the instance will be placed"
  type        = string
  
}

variable "security_group_ids" {
  description = "List of security group IDs to assign to the instance"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "IAM instance profile for EC2 instances"
  type        = string
}