output "website_url" {
  description = "My website URL"
  value       = "http://${aws_s3_bucket_website_configuration.web-conf.website_endpoint}"
}