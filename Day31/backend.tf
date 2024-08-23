terraform {
  backend "s3" {
    bucket         = "my-new-terraform-state-bucket-sp"
    key            = "terraform/state.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-lock-tbl"
  }
}
