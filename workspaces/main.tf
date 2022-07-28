# module block to automatically create workspaces in terraform cloud
module "main-workspaces" {
  source       = "../modules/tfe_workspace"
  workspaces   = var.workspaces
  organization = "mypracticelab"
}
