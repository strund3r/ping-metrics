resource "kubernetes_cluster_role_binding" "ping_metrics" {
  metadata {
    name = "ping-metrics"
    labels = {
      app = "ping-metrics"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "ping-metrics"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "ping-metrics"
    namespace = var.k8s_namespace
  }
}

resource "kubernetes_cluster_role_binding" "node_exporter" {
  metadata {
    name = "node-exporter"
    labels = {
      app = "node-exporter"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "node-exporter"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "node-exporter"
    namespace = var.k8s_namespace
  }
}
