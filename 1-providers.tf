# set of functions specific to a cloud/open-source project

provider "aws" {
    region = local.region
}

# Defining contraints on versions

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.2"
}
