#Using terraform cloud backend to store state and prfix to reference worksapces
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "mypracticelab"

    workspaces {
      prefix = "main-dev"
    }
  }
}