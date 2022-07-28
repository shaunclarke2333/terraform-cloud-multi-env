# list of workspaces to be created
variable "workspaces" {
  type        = list(any)
  description = "list of workspace names"
  default     = ["main-prod", "main-test", "main-dev"]
}
