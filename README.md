# EKS + Prometheus + Grafana

## Requirements

* AWS CLI
* Terraform
* Python3
* boto3

## Execute

After installing AWS CLI, run the following command to configure it and enable Terraform access to the configuration file:

```shell
$ aws configure
AWS Access Key ID [None]: <YOUR_AWS_ACCESS_KEY_ID>
AWS Secret Access Key [None]: <YOUR_AWS_SECRET_ACCESS_KEY>
Default region name [None]: <YOUR_AWS_REGION>
Default output format [None]: json
```

You can execute using Makefile

```shell
$ make
```

To list all commands, check help

```shell
$ make help
apply_all                      Creates everything that was specified [DEFAULT]
apply_eks                      Creates an EKS Cluster
apply_monitoring               Deploy Monitoring
apply_s3                       Creates an S3 Bucket
destroy_all                    Destroys everything that was created with Terraform
destroy_eks                    Destroys the EKS Cluster that was created with Terraform
destroy_monitoring             Destroys monitoring that was created with Terraform
destroy_s3                     Destroys the S3 Bucket that was created with Terraform
help                           Show this help
```
