resource "aws_eks_node_group" "eks_node" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "worker_node"
  node_role_arn   = aws_iam_role.worker_node.arn
  subnet_ids      = aws_subnet.eks[*].id
  instance_types  = ["t2.medium"]
  disk_size       = 10

  # Enables SSH access to the worker nodes using .pem key
  remote_access {
    ec2_ssh_key = module.key_pair.this_key_pair_key_name
  }

  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 1
  }

  depends_on = [
    module.key_pair,
    aws_iam_role_policy_attachment.worker_node,
    aws_iam_role_policy_attachment.worker_cni,
    aws_iam_role_policy_attachment.worker_ecs_read_only,
  ]
}
