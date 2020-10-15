resource "kubernetes_daemonset" "ping_metrics" {
  metadata {
    name      = "ping-metrics"
    namespace = var.k8s_namespace
    labels = {
      app = "ping-metrics"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "ping-metrics"
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_unavailable = "1"
      }
    }

    template {
      metadata {
        labels = {
          app = "ping-metrics"
        }
      }

      spec {
        container {
          name  = "ping-metrics"
          image = "czerwonk/ping_exporter"
          port {
            container_port = 9427
          }
          volume_mount {
            name       = "config"
            mount_path = "/config"
          }
        }

        volume {
          name = "config"
          config_map {
            name = "ping-metrics"
          }
        }

        host_network         = true
        service_account_name = "ping-metrics"
      }
    }
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}

resource "kubernetes_daemonset" "node_exporter" {
  metadata {
    name      = "node-exporter"
    namespace = var.k8s_namespace
    labels = {
      app = "node-exporter"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "node-exporter"
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_unavailable = "1"
      }
    }

    template {
      metadata {
        labels = {
          app = "node-exporter"
        }
      }

      spec {
        container {
          name  = "node-exporter"
          image = "prom/node-exporter"
          args  = ["--collector.textfile.directory=/collector/"]
          port {
            container_port = 9100
          }
          volume_mount {
            name       = "promfile"
            mount_path = "/collector/"
          }
        }

        volume {
          name = "promfile"
          host_path {
            path = "/var/lib/ping_collector/"
          }
        }

        host_network         = true
        service_account_name = "node-exporter"
      }
    }
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}
