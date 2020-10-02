resource "tls_private_key" "eks" {
  algorithm = "RSA"
}

# Creates a .pem with the content of 'tls_private_key'
resource "local_file" "eks_pem" {
  content         = tls_private_key.eks.public_key_openssh
  filename        = "eks.pem"
  file_permission = "0400"

  depends_on = [
    tls_private_key.eks
  ]
}

# resource "aws_key_pair" "eks" {
#     key_name = "eks"
#     public_key = tls_private_key.eks.public_key_openssh

#     depends_on = [
#         tls_private_key.eks
#     ]
# }

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "eks"
  public_key = tls_private_key.eks.public_key_openssh

  depends_on = [
    local_file.eks_pem
  ]
}