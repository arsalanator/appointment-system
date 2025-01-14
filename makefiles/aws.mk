list-aws-infrastructure-commands:
	@echo "	make deploy-infra - deploys AWS infrastructure setup found at deployments/aws/cloudformation/*"
	@echo "	make destroy-infra - destroys AWS infrastructure setup created through deployments/aws/cloudformation/*"
	@echo "	make validate-templates - validates AWS infrastructure setup found at deployments/aws/cloudformation/*"

.PHONY: deploy-infra destroy-infra validate-templates

deploy-infra:
	aws cloudformation deploy \
		--template-file deployments/aws/cloudformation/main.yaml \
		--stack-name $(AWS_CLOUD_FORMATION_STACK_NAME) \
		--parameter-overrides Environment=dev \
		--capabilities CAPABILITY_IAM

destroy-infra:
	aws cloudformation delete-stack \
		--stack-name $(AWS_CLOUD_FORMATION_STACK_NAME)

validate-templates:
	aws cloudformation validate-template \
		--template-body file://deployments/aws/cloudformation/main.yaml
	aws cloudformation validate-template \
		--template-body file://deployments/aws/cloudformation/storage.yaml
	aws cloudformation validate-template \
		--template-body file://deployments/aws/cloudformation/instances.yaml
	aws cloudformation validate-template \
		--template-body file://deployments/aws/cloudformation/iam.yaml
	aws cloudformation validate-template \
		--template-body file://deployments/aws/cloudformation/network.yaml