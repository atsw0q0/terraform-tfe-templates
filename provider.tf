provider "tfe" {
  hostname = var.hostname # Optional, defaults to HCP Terraform `app.terraform.io`
  token    = var.token
  version  = "~> 0.58.1"
}

provider "aws" {
  region = "ap-northeast-1"
}