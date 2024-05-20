

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.website_endpoint
    origin_id   = var.website_id
    custom_origin_config {
      origin_protocol_policy = "https-only"
      http_port              = 80
      https_port             = 443
      origin_ssl_protocols   = ["TLSv1.2", "TLSv1.1", "TLSv1"]
    }

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Config do Portal"
  default_root_object = "index.html"

  aliases = []

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.bucket_ec

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
  dynamic "ordered_cache_behavior" {
    for_each = var.ordered_cache_behavior
    content {
      path_pattern     = ordered_cache_behavior.value.path_pattern
      allowed_methods  = ordered_cache_behavior.value.allowed_methods
      cached_methods   = ordered_cache_behavior.value.cached_methods
      target_origin_id = var.bucket_ec

      function_association {
        event_type   = "viewer-request"
        function_arn = aws_cloudfront_function.test.arn
      }

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
      viewer_protocol_policy = ordered_cache_behavior.value.viewer_protocol_policy
    }
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
  # depends_on = [
  #   aws_cloudfront_origin_access_identity.default,
  # ]
}

resource "aws_cloudfront_function" "test" {
  name    = "portal-robsonross"
  runtime = "cloudfront-js-2.0"
  comment = "Function Para auxiliar"
  publish = true
  code    = file("${path.module}/function.js")
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

