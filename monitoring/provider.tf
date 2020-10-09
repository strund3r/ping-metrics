terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.13"
    }
    grafana = {
      source  = "grafana/grafana"
      version = "~> 1.5"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.6"
    }
  }
}

provider "kubernetes" {}

provider "grafana" {
  url  = "http://${kubernetes_service.grafana.load_balancer_ingress[0].hostname}:3000"
  auth = "admin:admin" #var.grafana_auth
}

provider "time" {}