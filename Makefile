.PHONY: apply_all
apply_all: apply_s3 apply_eks apply_monitoring  ## Creates everything that was specified [DEFAULT]

.PHONY: destroy_all
destroy_all: destroy_monitoring destroy_eks destroy_s3 ## Destroys everything that was created with Terraform

.PHONY:
apply_s3: ## Creates an S3 Bucket
	@cd s3; echo "\e[42m\e[30m          \e[4mApplying S3\e[24m          \e[39m\033[0m"; terraform init; terraform plan -out main.plan; terraform apply -auto-approve

.PHONY:
destroy_s3: ## Destroys the S3 Bucket that was created with Terraform
	@cd s3; echo "\e[41m          \e[4mDestroying S3\e[24m          \033[0m"; python3 empty-s3.py; terraform destroy -auto-approve

.PHONY:
apply_eks: ## Creates an EKS Cluster
	@cd eks; echo "\e[42m\e[30m          \e[4mApplying EKS\e[24m          \e[39m\033[0m"; terraform init; terraform plan -out main.plan; terraform apply -auto-approve
 
.PHONY:
destroy_eks: ## Destroys the EKS Cluster that was created with Terraform
	@cd eks; echo "\e[41m          \e[4mDestroying EKS\e[24m          \e[39m\033[0m"; terraform destroy -auto-approve

.PHONY:
apply_monitoring: ## Deploy Monitoring
	@cd monitoring; echo "\e[42m\e[30m          \e[4mApplying Monitoring\e[24m          \e[39m\033[0m"; terraform init; terraform plan -out main.plan; terraform apply -auto-approve

.PHONY:
destroy_monitoring: ## Destroys monitoring that was created with Terraform
	@cd monitoring; echo "\e[41m          \e[4mDestroying Monitoring\e[24m          \033[0m"; terraform destroy -auto-approve

.PHONY: help
help: ## Show this help
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'