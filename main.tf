# 


# Organizations
resource "tfe_organization" "main" {
  name  = format("%s-%s-%s", var.pj_prefix.name, var.pj_prefix.env, var.pj_prefix.org_name)
  email = var.org_manager_email
}


# Projects
resource "tfe_project" "pj" {
  organization = tfe_organization.main.name
  name         = format("%s-%s-%s", var.pj_prefix.name, var.pj_prefix.env, var.pj_prefix.project_name)
}


# Workspaces
resource "tfe_workspace" "network" {
  name         = format("%s-%s-%s", var.pj_prefix.name, var.pj_prefix.env, var.pj_prefix.workspace_name)
  organization = tfe_organization.main.name
  project_id   = tfe_project.pj.id
  vcs_repo {
    identifier                 = var.vcs_repository
    branch                     = "main"
    github_app_installation_id = var.github_app_installation_id
  }
  working_directory = var.repository_working_directory
}

resource "tfe_workspace_settings" "network" {
  workspace_id = tfe_workspace.network.id
  #   execution_mode = "remote"
}


# Environment
resource "tfe_variable" "env_tfc_aws_provider_auth" {
  key          = "TFC_AWS_PROVIDER_AUTH"
  value        = "true"
  category     = "env"
  workspace_id = tfe_workspace.network.id

  depends_on = [aws_iam_role.role, tfe_workspace.network]
}

resource "tfe_variable" "env_tfc_aws_run_role_arn" {
  key          = "TFC_AWS_RUN_ROLE_ARN"
  value        = aws_iam_role.role.arn
  category     = "env"
  workspace_id = tfe_workspace.network.id

  depends_on = [aws_iam_role.role, tfe_workspace.network]
}


resource "tfe_variable" "tfm_hcl_pj_tag" {
  key = "pj_tags"
  value = jsonencode(
    # { 
    #     name = "hoge"
    #     env  = "test"
    # }
    var.pj_tfm_vars
  )
  category     = "terraform"
  hcl          = true
  workspace_id = tfe_workspace.network.id

  depends_on = [aws_iam_role.role, tfe_workspace.network]
}
