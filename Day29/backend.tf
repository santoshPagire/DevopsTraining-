terraform {
  backend "s3" {
    bucket         = var.pre_bucket_name
    key            = "terraform/state.tfstate"
    region         = var.region
    encrypt        = true
    dynamodb_table = var.table_name
  }
}
