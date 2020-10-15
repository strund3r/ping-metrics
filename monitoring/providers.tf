terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
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
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1"
    }
  }
}

provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = var.aws_credential
  profile                 = var.aws_profile
}

provider "kubernetes" {}

provider "grafana" {
  url  = "http://${kubernetes_service.grafana.load_balancer_ingress[0].hostname}:3000"
  auth = var.grafana_auth
}

provider "time" {}
