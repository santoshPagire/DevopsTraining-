variable "bucket" {
  type = string
  default = "my-test-terraform-state-bucket12"
}

variable "name" {
  type = string
  default = "terraform-test-lock"
}

variable "region" {
  type = string
  default = "us-east-1"
}