variable "origin" {
  type    = string
  default = "Origin"
}

variable "website_endpoint" {
  description = "Nome do dominio atribuido"
}

variable "website_id" {
  description = "Nome da origin atribuido ao cloudfront"
}

variable "bucket_ec" {
  description = "Nome do bucket que será a origem dos dados"

}

# variable "s3_content" {
#   type        = set(string)
#   description = "The default content of the s3 bucket upon creation of the bucket"
# }

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
      allowed_methods        = []
      cached_methods         = []
      path_pattern           = ""
      viewer_protocol_policy = ""
    }
  }
}