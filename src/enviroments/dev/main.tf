terraform {
  # backend "s3" {
  #   region         = "us-east-1"
  #   bucket         = "aim-ahead-tf-state-bucket-dev"
  #   key            = "tf-infra/terraform.tfstate" 
  #   dynamodb_table = "aim-ahead-tf-state-locking-dev"
  #   encrypt        = true
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = local.region

  default_tags {
    tags = {
      Environment = local.enviroment
      project     = local.project_name
    }
  }
}


module "tf-state" {
  source = "../../modules/state"

  bucket_name    = "aim-ahead-tf-state-bucket-dev"
  dynamodb_table = "aim-ahead-tf-state-locking-dev"
}

# module "service" {
#   source = "../../modules/services"

#   env          = local.enviroment
#   project_name = local.project_name
# }

# module "repository" {
#   source = "../../modules/repository"
# 
#   project_name = local.project_name
# }