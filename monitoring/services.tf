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

resource "kubernetes_service" "cadvisor" {
  metadata {
    name = "cadvisor"
    #namespace = var.k8s_namespace
  }
  spec {
    selector = {
      app = kubernetes_deployment.cadvisor.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 8080
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_service" "kube_state_metrics" {
  metadata {
    name = "kube-metrics-service"
    #namespace = var.k8s_namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.kube_state_metrics.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "metrics"
      port        = 8080
      target_port = 8080

    }
    port {
      name        = "telemetry"
      port        = 8081
      target_port = 8081
    }
    type = "LoadBalancer"
  }
}
