# 


# Organizations
resource "tfe_organization" "test" {
  name  = format("%s-%s-org", var.pj_tags.name, var.pj_tags.env)
  email = var.org_manager_email
}


# Projects
resource "tfe_project" "aws" {
  organization = tfe_organization.test.name
  name         = "pj-aws"
}


# Workspaces
resource "tfe_workspace" "mokumoku" {
  name         = format("%s-%s-mokumoku", var.pj_tags.name, var.pj_tags.env)
  organization = tfe_organization.test.name
  project_id   = tfe_project.aws.id
  vcs_repo {
    identifier                 = var.vcs_repository
    branch                     = "main"
    github_app_installation_id = var.github_app_installation_id

  }
}

resource "tfe_workspace_settings" "mokumoku" {
  workspace_id = tfe_workspace.mokumoku.id
  #   execution_mode = "remote"
}


# Environment
resource "tfe_variable" "env_tfc_aws_provider_auth" {
  key          = "TFC_AWS_PROVIDER_AUTH"
  value        = "true"
  category     = "env"
  workspace_id = tfe_workspace.mokumoku.id

  depends_on = [aws_iam_role.role, tfe_workspace.mokumoku]
}

resource "tfe_variable" "env_tfc_aws_run_role_arn" {
  key          = "TFC_AWS_RUN_ROLE_ARN"
  value        = aws_iam_role.role.arn
  category     = "env"
  workspace_id = tfe_workspace.mokumoku.id

  depends_on = [aws_iam_role.role, tfe_workspace.mokumoku]
}


resource "tfe_variable" "tfm_hcl_pj_tag" {
  key = "pj_tags"
  value = jsonencode(
    # { 
    #     name = "chuosen"
    #     env  = "test"
    # }
    var.pj_tfm_vars
  )
  category     = "terraform"
  hcl          = true
  workspace_id = tfe_workspace.mokumoku.id

  depends_on = [aws_iam_role.role, tfe_workspace.mokumoku]
}
