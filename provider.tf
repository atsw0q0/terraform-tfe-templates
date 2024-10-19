provider "tfe" {
  hostname = var.hostname # Optional, defaults to HCP Terraform `app.terraform.io`
  token    = var.token
}

provider "aws" {
  region = "ap-northeast-1"
}