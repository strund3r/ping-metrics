resource "kubernetes_service_account" "kube-service-account" {
  metadata {
    name = "kube-state-metrics"
    labels = {
      app = "kube-state-metrics"
    }
    #namespace = var.k8s_namespace
  }
}

resource "kubernetes_service_account" "cadvisor-service-account" {
  metadata {
    name = "cadvisor"
    labels = {
      app = "cadvisor"
    }
    #namespace = var.k8s_namespace
  }
}