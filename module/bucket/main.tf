#Politica do Bucket
resource "aws_s3_bucket" "ec" {
  bucket = var.s3name

  tags = {
    Name = var.tags
  }
}

resource "aws_s3_object" "ec" {
  for_each = var.s3_content
  bucket   = aws_s3_bucket.ec.id
  key      = "${each.value}/"
}

resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket.ec.id
  policy = data.aws_iam_policy_document.allow_access.json
}

resource "aws_cloudfront_origin_access_identity" "default" {
  comment = var.origin
}


data "aws_iam_policy_document" "allow_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.default.id}"]
    }
    actions = [
      "s3:GetObject",
    ]
    resources = [
      aws_s3_bucket.ec.arn,
      "${aws_s3_bucket.ec.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_cors_configuration" "corsrules" {
  bucket = aws_s3_bucket.ec.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://robsonross.com.br"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.ec.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

resource "aws_s3_bucket_ownership_controls" "ec" {
  bucket = aws_s3_bucket.ec.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "b_acl" {
  bucket     = aws_s3_bucket.ec.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.ec]
}

locals {
  s3_origin_id = var.cloudfront
}