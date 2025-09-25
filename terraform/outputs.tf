output "ecr_frontend_repo" {
  value = aws_ecr_repository.frontend.repository_url
}
output "ecr_backend_repo" {
  value = aws_ecr_repository.backend.repository_url
}
output "eks_cluster_name" { value = aws_eks_cluster.this.name }
output "postgres_endpoint" { value = aws_db_instance.postgres.endpoint }
output "jenkins_public_ip" { value = aws_instance.jenkins.public_ip }
