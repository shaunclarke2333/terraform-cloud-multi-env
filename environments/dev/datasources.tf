# data source for all workspace IDs
data "tfe_workspace_ids" "all-environments" {
  names        = ["main-prod", "main-dev", "main-test"]
  organization = "mypracticelab"
}
