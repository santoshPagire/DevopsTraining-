output "instance_public_ip" {
  value = module.ec2_s3.instance_public_ip
}

output "bucket_arn" {
  value = module.ec2_s3.bucket_arn
}