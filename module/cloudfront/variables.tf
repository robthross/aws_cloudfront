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
