resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket.ec.id
  policy = data.aws_iam_policy_document.allow_access.json
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