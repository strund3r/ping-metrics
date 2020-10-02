data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.eks.id
}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.eks.id
}

data "aws_availability_zones" "available" {}
