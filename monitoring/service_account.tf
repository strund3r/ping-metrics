resource "kubernetes_service_account" "ping_metrics" {
  metadata {
    name = "ping-metrics"
    labels = {
      app = "ping-metrics"
    }
    namespace = var.k8s_namespace
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}

resource "kubernetes_service_account" "node_exporter" {
  metadata {
    name = "node-exporter"
    labels = {
      app = "node-exporter"
    }
    namespace = var.k8s_namespace
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}
