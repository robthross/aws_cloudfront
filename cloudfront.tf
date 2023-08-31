resource "aws_s3_bucket" "ec" {
  bucket = var.s3name

  tags = {
    Name = var.tags
  }
}

resource "aws_s3_bucket_ownership_controls" "ec" {
  bucket = aws_s3_bucket.ec.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "b_acl" {
  bucket = aws_s3_bucket.ec.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.ec]
}

locals {
  s3_origin_id = var.cloudfront
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket_website_configuration.website.website_endpoint
    origin_id   = aws_s3_bucket_website_configuration.website.id

    custom_origin_config {
        origin_protocol_policy = "http-only"
        http_port = 80
        https_port = 443
        origin_ssl_protocols = ["TLSv1.2", "TLSv1.1", "TLSv1"]
      }
    # s3_origin_config {
    #   origin_access_identity = aws_cloudfront_origin_access_identity.default.cloudfront_access_identity_path
    # }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Config do Portal Exemplo"
  default_root_object = "index.html"

  # logging_config {
  #   include_cookies = false
  #   bucket          = aws_s3_bucket.ec.id
  #   prefix          = "myprefix"
  # }

  aliases = []

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.ec.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = aws_s3_bucket.ec.id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.ec.id
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["BR"]
    }
  }

  tags = {
    Environment = "develop"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  depends_on = [
    aws_cloudfront_origin_access_identity.default,
  ]
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

