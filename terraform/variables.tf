variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type    = string
  default = "3tier-eks"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "jenkins_key_name" {
  description = "SSH keypair name in AWS for Jenkins EC2"
  type        = string
}

variable "aws_account_id" {
  description = "Your account id (used to construct ECR URIs)"
  type        = string
}

# DB credentials (use sensitive var)
variable "db_username" { type = string }
variable "db_password" { type = string, sensitive = true }
