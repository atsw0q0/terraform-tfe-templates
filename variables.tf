variable "pj_prefix" {
  type = object({
    name           = string
    env            = string
    org_name       = string
    project_name   = string
    workspace_name = string
  })
  default = {
    name           = "hoge"
    env            = "test"
    org_name       = "org"
    project_name   = "project"
    workspace_name = "workspace"
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
  description = "select your vcs repository."
}

variable "repository_working_directory" {
  type        = string
  description = "select your working directory."
  default     = ""
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

