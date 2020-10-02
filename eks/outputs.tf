output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = var.eks_cluster_name
}

output "aws_region" {
  description = "AWS region."
  value       = var.aws_region
}

output "eks_cluster_endpoint" {
  description = "EKS Control Plane Endpoint."
  value       = aws_eks_cluster.eks.endpoint
}
