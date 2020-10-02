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

resource "kubernetes_deployment" "cadvisor" {
  metadata {
    name = "cadvisor"
    #namespace = var.k8s_namespace
    labels = {
      app = "cadvisor"
    }
  }
  spec {
    selector {
      match_labels = {
        app = "cadvisor"
      }
    }
    template {
      metadata {
        #namespace = var.k8s_namespace
        labels = {
          app = "cadvisor"
        }
      }
      spec {
        container {
          name  = "cadvisor"
          image = "k8s.gcr.io/cadvisor"
          port {
            container_port = 8080
          }
        }
        service_account_name            = "cadvisor"
        automount_service_account_token = true
      }
    }
  }
}

resource "kubernetes_deployment" "kube_state_metrics" {
  metadata {
    name = "kube-state-metrics"
    #namespace = var.k8s_namespace
    labels = {
      app = "kube-state-metrics"
    }
  }
  spec {
    selector {
      match_labels = {
        app = "kube-state-metrics"
      }
    }
    template {
      metadata {
        #namespace = var.k8s_namespace
        labels = {
          app = "kube-state-metrics"
        }
      }
      spec {
        container {
          name  = "kube-state-metrics"
          image = "quay.io/coreos/kube-state-metrics"
          port {
            container_port = 8080
          }
          port {
            container_port = 8081
          }
        }
        service_account_name            = "kube-state-metrics"
        automount_service_account_token = true
      }
    }
  }
}
