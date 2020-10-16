variable "k8s_namespace" {
  description = "Kubernetes monitoring namespace"
  type        = string
  default     = "monitoring"
}

variable "aws_profile" {
  description = "Name of AWS profile in AWS shared credentials file or AWS shared configuration file."
  type        = string
  default     = "default"
}

variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-east-1"
}

variable "aws_credential" {
  description = "Path to the AWS shared credentials file."
  type        = string
  default     = "~/.aws/credentials"
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  default     = "eks-cluster"
}

variable "grafana_auth" {
  description = "Grafana username and password (Usage: user:pass)"
  type        = string
  default     = "admin:admin"
}
