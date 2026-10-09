terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    bucket       = "dhoni-demo-terraform-bucket-123456"
    key          = "hubstatefile/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}    