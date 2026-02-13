terraform {
  required_version = ">= 1.13.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.20.0"
    }
  }
}

#copied from the PDF assignment
provider "aws" {
  region = "us-east-1"
skip_credentials_validation = true
skip_requesting_account_id  = true
skip_metadata_api_check     = true
access_key        = "mock_access_key"          
secret_key        = "mock_secret_key"

#tags
default_tags {
  tags = {
    "SRE_TASK": "momir_macesic"
  }
 }
}