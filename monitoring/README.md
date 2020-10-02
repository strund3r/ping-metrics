# Monitoring

## Execute

To execute, just run the following commands:

```shell
terraform init
terraform plan -out main.plan
terraform apply "main.plan"
```

To destroy, just run:

```shell
terraform destroy
```

## Requirements

| Name | Version |
|------|---------|
| kubernetes | ~> 1.13 |

## Providers

| Name | Version |
|------|---------|
| kubernetes | ~> 1.13 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| k8s\_namespace | Kubernetes monitoring namespace | `string` | `"monitoring"` | no |

## Outputs

| Name | Description |
|------|-------------|
| lb\_ip\_cadvisor | Show cAdvisor Load Balancer External IP |
| lb\_ip\_grafana | Show Grafana Loab Balancer External IP |
| lb\_ip\_metrics | Show kube-state-metrics Load Balancer External IP |
| lb\_ip\_prometheus | Show Prometheus Load Balancer External IP |
