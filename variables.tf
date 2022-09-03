variable "cloudfront" {
    type    = string
    default = "exemplo.com.br"
}

variable "tags" {
    type    = string
    default = "exemplo"
}

variable "origin" {
    type    = string
    default = "Origin"
}

variable "region" {
    type    = string
    default = "us-east-1"
}

# Essas variaveis tem finalidade apenas para teste
variable "AWS_ACCES_KEY_ID" {
    type    = string
    default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
    type    = string
    default = ""
}