output "lb_ip_prometheus" {
  description = "Show Prometheus Load Balancer External IP"
  value       = kubernetes_service.prometheus.load_balancer_ingress[0].hostname
}

output "lb_ip_grafana" {
  description = "Show Grafana Loab Balancer External IP"
  value       = kubernetes_service.grafana.load_balancer_ingress[0].hostname
}