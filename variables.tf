variable "s3name" {
  type    = string
  default = "robsonross"
}

variable "cloudfront" {
  type    = string
  default = "robsonross.com.br"
}

variable "tags" {
  type    = string
  default = "robsonross"
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
  default = "AKIA5X5I25IFKI47JUTT"
}

variable "AWS_SECRET_ACCESS_KEY" {
  type    = string
  default = "MQGnL0KLw8BZLpqSollT5wjoerz/cEJNBgqkyQ3H"
}