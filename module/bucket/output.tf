output "website_configuration" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "website_id" {
  value = aws_s3_bucket_website_configuration.website.id
}

output "bucket_ec" {
  value = aws_s3_bucket.ec.id
}