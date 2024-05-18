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
  type        = set(string)
  description = "The default content of the s3 bucket upon creation of the bucket"
}

variable "origin" {
  description = "Nome da Origin para associacao no cloudfront"

}