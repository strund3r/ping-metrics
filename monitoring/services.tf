resource "kubernetes_service" "grafana" {
  metadata {
    name = "grafana"
    #namespace = var.k8s_namespace
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
}

resource "kubernetes_service" "prometheus" {
  metadata {
    name = "prometheus-service"
    #namespace = var.k8s_namespace
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
}