terraform {
  required_version = ">= 1.11.0"

  backend "s3" {
    bucket               = "terraform-with-actions-demo"
    key                  = "terraform.tfstate"
    workspace_key_prefix = "env"
    region               = "eu-central-1"
    encrypt              = true
    use_lockfile         = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

module "app_bucket" {
  source            = "../../modules/s3_bucket"
  bucket_name       = "myapp-${terraform.workspace}-demo-bucket-1111"
  enable_versioning = true
  tags = {
    env = terraform.workspace
  }
}
