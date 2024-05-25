

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