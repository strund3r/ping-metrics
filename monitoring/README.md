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
| aws | ~> 3.0 |
| grafana | ~> 1.5 |
| kubernetes | ~> 1.13 |
| null | ~> 2.1 |
| time | ~> 0.6 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |
| grafana | ~> 1.5 |
| kubernetes | ~> 1.13 |
| local | n/a |
| null | ~> 2.1 |
| template | n/a |
| time | ~> 0.6 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_credential | Path to the AWS shared credentials file. | `string` | `"~/.aws/credentials"` | no |
| aws\_profile | Name of AWS profile in AWS shared credentials file or AWS shared configuration file. | `string` | `"default"` | no |
| aws\_region | AWS region. | `string` | `"us-east-1"` | no |
| eks\_cluster\_name | Name of the EKS cluster. | `string` | `"eks-cluster"` | no |
| grafana\_auth | Grafana username and password (Usage: user:pass) | `string` | `"admin:admin"` | no |
| k8s\_namespace | Kubernetes monitoring namespace | `string` | `"monitoring"` | no |

## Outputs

| Name | Description |
|------|-------------|
| lb\_ip\_grafana | Show Grafana Loab Balancer External IP |
| lb\_ip\_prometheus | Show Prometheus Load Balancer External IP |
