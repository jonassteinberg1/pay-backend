resource "aws_efs_file_system" "kubernetes" {
  creation_token = "kubernetes"

  tags = {
    Name = "kubernetes"
  }
}

output "file_system_id" {
  value = aws_efs_file_system.kubernetes.id
}

