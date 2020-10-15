resource "time_sleep" "wait_for_deployment" {
  depends_on = [kubernetes_deployment.grafana]

  create_duration = "120s"
}

resource "grafana_data_source" "prometheus" {
  type       = "prometheus"
  name       = "Prometheus"
  url        = "http://${kubernetes_service.prometheus.load_balancer_ingress[0].hostname}:9090"
  is_default = true

  depends_on = [time_sleep.wait_for_deployment]
}

data "template_file" "dashboard" {
  template = file("${path.module}/grafana-dashboard.json.template")
  vars = {
    node-1 = element(flatten([data.aws_instances.eks_nodes.*.private_ips]), 0)
    node-2 = element(flatten([data.aws_instances.eks_nodes.*.private_ips]), 1)
    node-3 = element(flatten([data.aws_instances.eks_nodes.*.private_ips]), 2)
  }
}

resource "local_file" "dashboard" {
  content  = data.template_file.dashboard.rendered
  filename = "grafana-dashboard.json"
}

resource "grafana_dashboard" "dashboard" {
  config_json = file("grafana-dashboard.json")

  depends_on = [
    grafana_data_source.prometheus,
    local_file.dashboard,
  ]
}
