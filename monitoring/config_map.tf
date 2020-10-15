resource "kubernetes_config_map" "prometheus" {
  metadata {
    name      = "prometheus"
    namespace = var.k8s_namespace
  }

  count = length(data.aws_instances.eks_nodes.private_ips)

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
      - job_name: 'ping-metrics'
        static_configs:
        - targets: ['${element(flatten([data.aws_instances.eks_nodes.*.private_ips]), 0)}:9427']
          labels:
            hostname: node-1
        - targets: ['${element(flatten([data.aws_instances.eks_nodes.*.private_ips]), 1)}:9427']
          labels:
            hostname: node-2
        - targets: ['${element(flatten([data.aws_instances.eks_nodes.*.private_ips]), 2)}:9427']
          labels:
            hostname: node-3
      - job_name: 'node-exporter'
        static_configs:
        - targets: ['${element(flatten([data.aws_instances.eks_nodes.*.private_ips]), 0)}:9100']
          labels:
            hostname: node-1
        - targets: ['${element(flatten([data.aws_instances.eks_nodes.*.private_ips]), 1)}:9100']
          labels:
            hostname: node-2
        - targets: ['${element(flatten([data.aws_instances.eks_nodes.*.private_ips]), 2)}:9100']
          labels:
            hostname: node-3
    EOF
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}

resource "kubernetes_config_map" "ping_metrics" {
  metadata {
    name      = "ping-metrics"
    namespace = var.k8s_namespace
  }

  data = {
    "config.yml" = <<EOF
    targets:
      - ${element(flatten([data.aws_instances.eks_nodes.*.private_ips]), 0)}
      - ${element(flatten([data.aws_instances.eks_nodes.*.private_ips]), 1)}
      - ${element(flatten([data.aws_instances.eks_nodes.*.private_ips]), 2)}

    dns:
      refresh: 2m15s
      nameserver: 1.1.1.1

    ping:
      interval: 2s
      timeout: 3s
      history-size: 42
      payload-size: 120
    EOF
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}
