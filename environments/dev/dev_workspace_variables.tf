# Adding aws_secret_access_key variable to global set
resource "tfe_variable" "public_subnet_cidr" {
  key          = "public_subnet_cidr"
  value        = "[\"10.3.0.0/24\"]"
  hcl          = true
  category     = "terraform"
  description  = "Dev public subnet CIDR"
  workspace_id = data.tfe_workspace_ids.all-environments.ids["main-dev"]
}

# Adding aws_access_key_id variable to global set
resource "tfe_variable" "vpc_cidr" {
  key          = "vpc_cidr"
  value        = "\"10.3.0.0/16\""
  hcl          = true
  category     = "terraform"
  description  = "Dev VPC CIDR"
  workspace_id = data.tfe_workspace_ids.all-environments.ids["main-dev"]
}

# Adding aws_region variable to global set
resource "tfe_variable" "environment" {
  key          = "environment"
  value        = "\"dev\""
  hcl          = true
  category     = "terraform"
  description  = "environment identifier variable"
  workspace_id = data.tfe_workspace_ids.all-environments.ids["main-dev"]
}