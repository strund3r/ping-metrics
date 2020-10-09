resource "time_sleep" "wait_for_deployment" {
  depends_on = [kubernetes_deployment.grafana]

  create_duration = "90s"
}

resource "grafana_data_source" "prometheus" {
  type       = "prometheus"
  name       = "Prometheus"
  url        = "http://${kubernetes_service.prometheus.load_balancer_ingress[0].hostname}:9090"
  is_default = true

  depends_on = [time_sleep.wait_for_deployment]
}