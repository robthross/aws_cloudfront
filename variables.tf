

variable "region" {
  type    = string
  default = "us-east-1"
}

# Essas variaveis tem finalidade apenas para teste
# variable "AWS_ACCES_KEY_ID" {
#   type    = string
#   default = ""
# }

# variable "AWS_SECRET_ACCESS_KEY" {
#   type    = string
#   default = ""
# }

variable "s3name" {
  description = "Nome Dados ao S3 Bucket"
}

variable "tags" {
  description = "Tags Dadas ao Bucket"
}

variable "cloudfront" {
  description = "No do cloudfront atribuido ao bucket"
}

variable "s3_content" {
  description = "The default content of the s3 bucket upon creation of the bucket"
  type        = set(string)
}

variable "origin" {
  description = "Nome da Origin para associacao no cloudfront"
}

variable "ordered_cache_behavior" {
  type = map(object({
    path_pattern           = string
    allowed_methods        = list(string)
    cached_methods         = list(string)
    viewer_protocol_policy = string
  }))
  description = "Map of ordered cache behaviors."

  default = {
    "ordered_cache_behavior_1" = {
      allowed_methods        = ["GET", "HEAD", "OPTIONS"]
      cached_methods         = ["GET", "HEAD"]
      path_pattern           = "/painel/*"
      viewer_protocol_policy = "redirect-to-https"
    }
    "ordered_cache_behavior_2" = {
      allowed_methods        = ["GET", "HEAD", "OPTIONS"]
      cached_methods         = ["GET", "HEAD"]
      path_pattern           = "/associacao/*"
      viewer_protocol_policy = "redirect-to-https"
    }
  }
}
