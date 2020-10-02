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
      
      - job_name: 'kube-state-metrics'
        static_configs:
        - targets: ['${kubernetes_service.kube_state_metrics.load_balancer_ingress[0].hostname}:8080']
      
      - job_name : 'cadvisor'
        static_configs:
        - targets: ['${kubernetes_service.cadvisor.load_balancer_ingress[0].hostname}:8080']
    EOF
  }
}
