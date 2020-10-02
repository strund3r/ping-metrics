locals {
  config_map_aws_auth = <<EOF

apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.worker_node.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
          - system:bootstrappers
          - system:nodes
EOF

  kubeconfig = <<EOF

apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks.endpoint}
    certificate-authority-data: ${aws_eks_cluster.eks.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.eks_cluster_name}"
EOF
}

# Configure kubetcl to access the cluster with AWS access credentials
# https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html
resource "null_resource" "eks_connect" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.eks_cluster_name}"
  }

  depends_on = [
    aws_eks_cluster.eks
  ]
}
