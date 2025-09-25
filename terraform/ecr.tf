resource "aws_ecr_repository" "frontend" {
  name = "3tier-frontend"
}

resource "aws_ecr_repository" "backend" {
  name = "3tier-backend"
}
