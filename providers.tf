terraform {
  backend "s3" {
    bucket         = "tf-backend-antonioaws-journey.com"
    key            = "dev/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "tf-backend-antonioaws-journey.com"
    encrypt        = true
    
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.67.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "default"
  default_tags {
    tags = {
      Owner     = "Antonio-TF"
      Project   = "AWS Cloud Resume Challange"
      Terraform = "True"
    }
  }
}