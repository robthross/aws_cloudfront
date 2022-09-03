terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.16.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
  access_key = var.AWS_ACCES_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}