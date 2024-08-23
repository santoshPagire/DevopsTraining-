

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  #acl    = "private"

  tags = {
    Name = var.bucket_name
  }
}







# resource "aws_s3_bucket" "app_bucket" {
#   bucket = var.bucket_name
#   # acl    = "private"

#   tags = {
#     Name = join("-", [var.bucket_name, "bucket"])
#   }
# }
