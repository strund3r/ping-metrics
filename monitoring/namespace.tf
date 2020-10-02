resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.k8s_namespace
  }
}
