resource "kubernetes_cluster_role_binding" "kube_state_metrics" {
  metadata {
    name = "kube-state-metrics"
    labels = {
      app = "kube-state-metrics"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "kube-state-metrics"
  }
  subject {
    kind = "ServiceAccount"
    name = "kube-state-metrics"
    #namespace = var.k8s_namespace
  }
}

resource "kubernetes_cluster_role_binding" "cadvisor" {
  metadata {
    name = "cadvisor"
    labels = {
      app = "cadvisor"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cadvisor"
  }
  subject {
    kind = "ServiceAccount"
    name = "cadvisor"
    #namespace = var.k8s_namespace
  }
}