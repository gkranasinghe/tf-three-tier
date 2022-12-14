output "s3_website_endpoint" {
  value = "${aws_s3_bucket.www.website_endpoint}"
}

# output "route53_domain" {
#   value = "${aws_route53_record.root_domain.fqdn}"
# }

output "cdn_domain" {
  value = "${aws_cloudfront_distribution.cdn.domain_name}"
}