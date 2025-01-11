list-k8-commands:
	@echo "	make k8s-deploy"
	@echo "	make k8s-delete"
	@echo "	make k8s-create-namespace"
	@echo "	make k8s-deploy-configs"
	@echo "	make k8s-deploy-services"
	@echo "	make k8s-deploy-deployments"

k8s-deploy:
	kubectl apply -f k8s/

k8s-delete:
	kubectl delete namespace $(K8S_NAMESPACE)

k8s-create-namespace:
	kubectl create namespace $(K8S_NAMESPACE)

k8s-deploy-configs:
	kubectl apply -f k8s/configmaps/ -n $(K8S_NAMESPACE)
	kubectl apply -f k8s/secrets/ -n $(K8S_NAMESPACE)

k8s-deploy-services:
	kubectl apply -f k8s/services/ -n $(K8S_NAMESPACE)

k8s-deploy-deployments:
	kubectl apply -f k8s/deployments/ -n $(K8S_NAMESPACE)