resource "kubernetes_service" "grafana" {
  metadata {
    name      = "grafana"
    namespace = var.k8s_namespace
  }
  spec {
    selector = {
      app = kubernetes_deployment.grafana.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 3000
      target_port = 3000
    }
    type = "LoadBalancer"
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}

resource "kubernetes_service" "prometheus" {
  metadata {
    name      = "prometheus-service"
    namespace = var.k8s_namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.prometheus.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 9090
      target_port = 9090
    }
    type = "LoadBalancer"
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}

resource "kubernetes_service" "ping_metrics" {
  metadata {
    name      = "ping-metrics-service"
    namespace = var.k8s_namespace
  }

  spec {
    selector = {
      app = kubernetes_daemonset.ping_metrics.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 9427
      target_port = 9427
    }
    type = "NodePort"
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}

resource "kubernetes_service" "node_exporter" {
  metadata {
    name      = "node-exporter-service"
    namespace = var.k8s_namespace
  }

  spec {
    selector = {
      app = kubernetes_daemonset.node_exporter.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 9100
      target_port = 9100
    }
    type = "NodePort"
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}
