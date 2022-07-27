# resource block to automatically create workspaces in terraform cloud
resource "tfe_workspace" "main" {
  for_each = toset(var.workspaces)

  name         = each.value
  organization = "mypracticelab"
  terraform_version = "1.1.8"
}

#getting the secret with teh aws keys
data "aws_secretsmanager_secret" "aws-keys-secret" {
  name = "aws_keys"
}

#Data source to retreive values from secret manager
data "aws_secretsmanager_secret_version" "aws-secret-names" {
  secret_id = data.aws_secretsmanager_secret.aws-keys-secret.id
}

# Using locals to assign the aws_access_key_id, aws_region and aws_secret_access_key name to the decoded json expression
locals {
  aws_secret_access_key = jsondecode(
    data.aws_secretsmanager_secret_version.aws-secret-names.secret_string
  )["aws_secret_access_key"]

  aws_access_key_id = jsondecode(
    data.aws_secretsmanager_secret_version.aws-secret-names.secret_string
  )["aws_access_key_id"]

  aws_region = jsondecode(
    data.aws_secretsmanager_secret_version.aws-secret-names.secret_string
  )["aws_region"]
}

#Global variable set to apply aws credentials to workspaces
resource "tfe_variable_set" "aws_creds" {
  name         = "aws_creds"
  description  = "Creds needed by workspaces to access aws."
  global       = true
  organization = "mypracticelab"
}

# Adding aws_secret_access_key variable to global set
resource "tfe_variable" "aws_secret_access_key" {
  key             = "AWS_SECRET_ACCESS_KEY"
  value           = local.aws_secret_access_key
  sensitive       = true
  category        = "env"
  description     = "aws secret access key"
  variable_set_id = tfe_variable_set.aws_creds.id
}

# Adding aws_access_key_id variable to global set
resource "tfe_variable" "aws_access_key_id" {
  key             = "AWS_ACCESS_KEY_ID"
  value           = local.aws_access_key_id
  sensitive       = true
  category        = "env"
  description     = "aws access key ID"
  variable_set_id = tfe_variable_set.aws_creds.id
}

# Adding aws_region variable to global set
resource "tfe_variable" "aws_region" {
  key             = "AWS_REGION"
  value           = local.aws_region
  sensitive       = true
  category        = "env"
  description     = "aws region"
  variable_set_id = tfe_variable_set.aws_creds.id
}
