data "aws_caller_identity" "current" {}

# data "aws_iam_openid_connect_provider" "terraform" {
#   count = var.is_create_iam_oidc_provider ? 0 : 1
#   url = "https://app.terraform.io"
# }

resource "aws_iam_openid_connect_provider" "terraform" {
  count = var.is_create_iam_oidc_provider ? 1 : 0
  url   = "https://app.terraform.io"
  client_id_list = [
    "aws.workload.identity",
  ]

  thumbprint_list = [
    "9e99a48a9960b14926bb7f3b02e22da2b0ab7280",
  ]
  tags = {
    PJ  = var.pj_tags.name
    Env = var.pj_tags.env
  }
}


resource "aws_iam_role" "role" {
  name = format("%s-%s-role-hcptfm-mokumoku", var.pj_tags.name, var.pj_tags.env)
  path = "/"
  assume_role_policy = templatefile(
    "./files/iam_trust_relationship.json",
    {
      account_id   = data.aws_caller_identity.current.account_id
      organization = tfe_organization.test.id
      project      = "*" # pj-aws
      workspace    = "*" # format("%s-%s-mokumoku", var.pj_tags.name, var.pj_tags.env)
    }
  )
  max_session_duration = 3600
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
  tags = {
    PJ  = var.pj_tags.name
    Env = var.pj_tags.env
  }
}