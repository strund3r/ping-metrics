resource "kubernetes_deployment" "grafana" {
  metadata {
    name      = "grafana"
    namespace = var.k8s_namespace
    labels = {
      app = "grafana"
    }
  }
  spec {
    selector {
      match_labels = {
        app = "grafana"
      }
    }
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge = "1"
      }
    }
    template {
      metadata {
        namespace = var.k8s_namespace
        labels = {
          app = "grafana"
        }
      }
      spec {
        container {
          name  = "grafana"
          image = "grafana/grafana"
          port {
            container_port = 3000
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}

resource "kubernetes_deployment" "prometheus" {
  metadata {
    name      = "prometheus"
    namespace = var.k8s_namespace
    labels = {
      app = "Prometheus"
    }
  }
  spec {
    selector {
      match_labels = {
        app = "Prometheus"
      }
    }
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge = "1"
      }
    }
    template {
      metadata {
        namespace = var.k8s_namespace
        labels = {
          app = "Prometheus"
        }
      }
      spec {
        container {
          name  = "prometheus"
          image = "prom/prometheus:v2.21.0"
          args  = ["--config.file=/prometheus.yml"]
          port {
            container_port = 9090
          }
          volume_mount {
            name       = "prometheus"
            mount_path = "/prometheus.yml"
            sub_path   = "prometheus.yml"
          }
        }
        volume {
          name = "prometheus"
          config_map {
            name = "prometheus"
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}
