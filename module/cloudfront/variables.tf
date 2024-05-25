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

variable "path_pattern" {
  type        = list(string)
  description = "Map of ordered cache behaviors."
  # default = [ "associacao", "painel", "cadastro", "meus-dados", "vr-pague", "financeiro" ]
}

variable "allowed_methods" {
  description = "Valores dos metodos permitidos"
}

variable "cached_methods" {
  description = "Valores de cache permitido"
}