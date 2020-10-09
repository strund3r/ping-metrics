resource "kubernetes_config_map" "prometheus" {
  metadata {
    name = "prometheus"
    #namespace = var.k8s_namespace
  }

  data = {
    #"prometheus.yml" = "${file("${path.module}/prometheus.yml")}"
    "prometheus.yml" = <<EOF
    global:
      scrape_interval:     15s
      evaluation_interval: 15s
    scrape_configs:
      - job_name: 'prometheus'
        static_configs:
        - targets: ['localhost:9090']
    EOF
  }
}