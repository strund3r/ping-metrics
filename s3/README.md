# S3

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

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_credential | Path to the AWS shared credentials file. | `string` | `"~/.aws/credentials"` | no |
| aws\_profile | Name of AWS profile in AWS shared credentials file or AWS shared configuration file. | `string` | `"default"` | no |
| aws\_region | AWS region. | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| eks\_s3\_bucket\_domain\_name | Print EKS S3 bucket domain name |
| monitoring\_s3\_bucket\_domain\_name | Print monitoring S3 bucket domain name |
