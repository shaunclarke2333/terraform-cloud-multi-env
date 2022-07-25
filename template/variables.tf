# public subnet ip addresses CIDR blocks for staging
variable "public_subnet_cidr" {
  description = "public subnet ip addresses CIDR blocks"

}

# vpc cidr block for the staging environment
variable "vpc_cidr" {
  description = "VPC ip addresses CIDR block"
}

# declaring environment variable to define terraform cloud workspace
variable "environment" {
  type        = string
  description = "Environment"
}