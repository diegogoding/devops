terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "local" {
    path = "state/terraform.tfstate"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
