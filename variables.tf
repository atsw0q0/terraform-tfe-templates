variable "pj_tags" {
  type = object({
    name = string
    env  = string
  })
  default = {
    name = "hoge"
    env  = "test"
  }
}


variable "hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "hostname"
}

variable "token" {
  type        = string
  description = "HCP Terraform API Token"
}

variable "org_manager_email" {
  type        = string
  description = "Organizaitons Manager E-Mail"
}

variable "vcs_repository" {
  type        = string
  description = "select your vcs repository"
}

variable "github_app_installation_id" {
  type        = string
  description = "select your vcs repository"
}

variable "is_create_iam_oidc_provider" {
  type        = bool
  description = "if app.terraform.io of IAM OIDC Provider is already exists, select false"
  default     = false
}

variable "pj_tfm_vars" {
  type        = map(any)
  description = "set workspace variables as tfm hcl"
  default     = {}
}

