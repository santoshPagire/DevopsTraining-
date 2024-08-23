variable "bucket" {
  type = string
  default = "my-new-terraform-state-bucket-sp"
}

variable "name" {
  type = string
  default = "terraform-lock-tbl"
}

variable "region" {
  type = string
  default = "us-west-2"
}