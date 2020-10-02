# EKS

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
| kubernetes | ~> 1.13 |
| local | ~> 1.4 |
| null | ~> 2.1 |
| tls | ~> 2.2 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |
| local | ~> 1.4 |
| null | ~> 2.1 |
| tls | ~> 2.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_credential | Path to the AWS shared credentials file. | `string` | `"~/.aws/credentials"` | no |
| aws\_profile | Name of AWS profile in AWS shared credentials file or AWS shared configuration file. | `string` | `"default"` | no |
| aws\_region | AWS region. | `string` | `"us-east-1"` | no |
| eks\_cluster\_name | Name of the EKS cluster. | `string` | `"eks-cluster"` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_region | AWS region. |
| cluster\_name | Kubernetes Cluster Name |
| eks\_cluster\_endpoint | EKS Control Plane Endpoint. |
