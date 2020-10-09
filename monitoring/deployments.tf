resource "kubernetes_deployment" "grafana" {
  metadata {
    name = "grafana"
    #namespace = var.k8s_namespace
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
    template {
      metadata {
        #namespace = var.k8s_namespace
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
}

resource "kubernetes_deployment" "prometheus" {
  metadata {
    name = "prometheus"
    #namespace = var.k8s_namespace
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
    template {
      metadata {
        #namespace = var.k8s_namespace
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
}