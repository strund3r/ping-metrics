output "eks_s3_bucket_domain_name" {
    description = "Print EKS S3 bucket domain name"
    value = aws_s3_bucket.eks_state.bucket_domain_name
}

output "monitoring_s3_bucket_domain_name" {
    description = "Print monitoring S3 bucket domain name"
    value = aws_s3_bucket.monitoring_state.bucket_domain_name
}