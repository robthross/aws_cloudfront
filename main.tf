terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.34.0"
    }
  }
  backend "s3" {
    bucket = "opensamba-terraform"
    key    = "statico/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  # Configuration options
  region = var.region
  #   access_key = var.AWS_ACCES_KEY_ID
  #   secret_key = var.AWS_SECRET_ACCESS_KEY
}

module "bucket" {
  source     = "./module/bucket"
  s3name     = var.s3name
  tags       = var.tags
  cloudfront = var.cloudfront
  s3_content = var.s3_content
  origin     = var.origin
}

module "cloudfront" {
  source           = "./module/cloudfront"
  website_endpoint = module.bucket.website_configuration
  website_id       = module.bucket.website_id
  bucket_ec        = module.bucket.bucket_ec
  origin           = var.origin
  path_pattern     = var.path_pattern
  allowed_methods  = var.allowed_methods
  cached_methods   = var.cached_methods
  domain-aliases   = var.domain-aliases
}