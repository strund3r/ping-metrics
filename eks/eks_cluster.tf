resource "aws_eks_cluster" "eks" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    security_group_ids = [aws_security_group.eks.id]
    subnet_ids         = aws_subnet.eks[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster
  ]
}
