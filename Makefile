# Variables
FRONTEND_DIR := user-facing-frontend
BACKEND_DIR := user-facing-backend
USER_FACING_FRONTEND_DIR := user-facing-frontend/React-Typescipt
USER_FACING_BACKEND_DIR := user-facing-backend/Express-Typescipt
CACHE_DB_DIR := databases/cache-database/Redis-IOredis-Typescript
CONTENT_DB_DIR := databases/content-database/Mongodb-Mongoose-Typescript
TRANSACTION_DB_DIR := databases/transactions-database/Mysql-TypeORM-Typescript
DOCKER_IMAGE := appointment-system
DOCKER_REGISTRY := your-docker-registry # Replace with actual registry
K8S_NAMESPACE := appointment-system
ENV_FILE := .env

run-lint-on-all:
	@$(MAKE) run-lint DIRECTORY=$(USER_FACING_FRONTEND_DIR)
	@$(MAKE) run-lint DIRECTORY=$(USER_FACING_BACKEND_DIR)
	@$(MAKE) run-lint DIRECTORY=$(CACHE_DB_DIR)
	@$(MAKE) run-lint DIRECTORY=$(CONTENT_DB_DIR)
	@$(MAKE) run-lint DIRECTORY=$(TRANSACTION_DB_DIR)

run-lint-fix-on-all:
	@$(MAKE) run-lint-fix DIRECTORY=$(USER_FACING_FRONTEND_DIR)
	@$(MAKE) run-lint-fix DIRECTORY=$(USER_FACING_BACKEND_DIR)
	@$(MAKE) run-lint-fix DIRECTORY=$(CACHE_DB_DIR)
	@$(MAKE) run-lint-fix DIRECTORY=$(CONTENT_DB_DIR)
	@$(MAKE) run-lint-fix DIRECTORY=$(TRANSACTION_DB_DIR)

run-prettier-format-on-all:
	@$(MAKE) run-prettier-format DIRECTORY=$(USER_FACING_FRONTEND_DIR)
	@$(MAKE) run-prettier-format DIRECTORY=$(USER_FACING_BACKEND_DIR)
	@$(MAKE) run-prettier-format DIRECTORY=$(CACHE_DB_DIR)
	@$(MAKE) run-prettier-format DIRECTORY=$(CONTENT_DB_DIR)
	@$(MAKE) run-prettier-format DIRECTORY=$(TRANSACTION_DB_DIR)

run-prettier-format-check-on-all:
	@$(MAKE) run-prettier-format-check DIRECTORY=$(USER_FACING_FRONTEND_DIR)
	@$(MAKE) run-prettier-format-check DIRECTORY=$(USER_FACING_BACKEND_DIR)
	@$(MAKE) run-prettier-format-check DIRECTORY=$(CACHE_DB_DIR)
	@$(MAKE) run-prettier-format-check DIRECTORY=$(CONTENT_DB_DIR)
	@$(MAKE) run-prettier-format-check DIRECTORY=$(TRANSACTION_DB_DIR)

run-lint-and-prettier-format-check-on-all:
	@$(MAKE) run-lint-and-prettier-format-check DIRECTORY=$(USER_FACING_FRONTEND_DIR)
	@$(MAKE) run-lint-and-prettier-format-check DIRECTORY=$(USER_FACING_BACKEND_DIR)
	@$(MAKE) run-lint-and-prettier-format-check DIRECTORY=$(CACHE_DB_DIR)
	@$(MAKE) run-lint-and-prettier-format-check DIRECTORY=$(CONTENT_DB_DIR)
	@$(MAKE) run-lint-and-prettier-format-check DIRECTORY=$(TRANSACTION_DB_DIR)

run-lint-fix-and-prettier-format-check-on-all:
	@$(MAKE) run-lint-fix-and-prettier-format-check DIRECTORY=$(USER_FACING_FRONTEND_DIR)
	@$(MAKE) run-lint-fix-and-prettier-format-check DIRECTORY=$(USER_FACING_BACKEND_DIR)
	@$(MAKE) run-lint-fix-and-prettier-format-check DIRECTORY=$(CACHE_DB_DIR)
	@$(MAKE) run-lint-fix-and-prettier-format-check DIRECTORY=$(CONTENT_DB_DIR)
	@$(MAKE) run-lint-fix-and-prettier-format-check DIRECTORY=$(TRANSACTION_DB_DIR)

run-lint:
	cd $(DIRECTORY)
	npm run lint
run-lint-fix:
	cd $(DIRECTORY)
	npm run lint:fix
run-prettier-format:
	cd $(DIRECTORY)
	npm run format
run-prettier-format-check:
	cd $(DIRECTORY)
	npm run format:check
run-lint-and-prettier-format-check:
	cd $(DIRECTORY)
	npm run check
run-lint-fix-and-prettier-format-check:
	cd $(DIRECTORY)
	npm run fix


# make BRANCH="set-branch-here" pull-from-all-subtrees
pull-from-all-subtrees:
	@$(MAKE) pull-from-backend-subtree BRANCH=$(BRANCH)
	@$(MAKE) pull-from-frontend-subtree BRANCH=$(BRANCH)
	@$(MAKE) pull-from-cache-database-subtree BRANCH=$(BRANCH)
	@$(MAKE) pull-from-content-database-subtree BRANCH=$(BRANCH)
	@$(MAKE) pull-from-transaction-database-subtree BRANCH=$(BRANCH)

# make BRANCH="set-branch-here" pull-from-backend-subtree
pull-from-backend-subtree:
	git subtree pull --prefix=user-facing-backend/Express-Typescipt origin $(BRANCH) --squash

# make BRANCH="set-branch-here" pull-from-frontend-subtree
pull-from-frontend-subtree:
	git subtree pull --prefix=user-facing-frontend/React-Typescipt origin $(BRANCH) --squash

# make BRANCH="set-branch-here" pull-from-cache-database-subtree
pull-from-cache-database-subtree:
	git subtree pull --prefix=databases/cache-database/Redis-IOredis-Typescript origin $(BRANCH) --squash

# make BRANCH="set-branch-here" pull-from-content-database-subtree
pull-from-content-database-subtree:
	git subtree pull --prefix=databases/content-database/Mongodb-Mongoose-Typescript origin $(BRANCH) --squash

# make BRANCH="set-branch-here" pull-from-transaction-database-subtree
pull-from-transaction-database-subtree:
	git subtree pull --prefix=databases/transactions-database/Mysql-TypeORM-Typescript origin $(BRANCH) --squash


# make BRANCH="set-branch-here" push-to-all-subtrees 
push-to-all-subtrees:
	@$(MAKE) push-to-transaction-database-subtree BRANCH=$(BRANCH)
	@$(MAKE) push-to-content-database-subtree BRANCH=$(BRANCH)
	@$(MAKE) push-to-cache-database-subtree BRANCH=$(BRANCH)
	@$(MAKE) push-to-backend-subtree BRANCH=$(BRANCH)
	@$(MAKE) push-to-frontend-subtree BRANCH=$(BRANCH)

# make BRANCH="set-branch-here" push-to-all-database-subtrees
push-to-all-database-subtrees:
	@$(MAKE) push-to-transaction-database-subtree BRANCH=$(BRANCH)
	@$(MAKE) push-to-content-database-subtree BRANCH=$(BRANCH)
	@$(MAKE) push-to-cache-database-subtree BRANCH=$(BRANCH)

# make BRANCH="set-branch-here" push-to-user-facing-frontends-and-backends-subtrees
push-to-user-facing-frontends-and-backends-subtrees:
	@$(MAKE) push-to-frontend-subtree BRANCH=$(BRANCH)
	@$(MAKE) push-to-backend-subtree BRANCH=$(BRANCH)

# push-to-transaction-database-subtree
# make BRANCH=installing-databases push-to-transaction-database-subtree
push-to-transaction-database-subtree:
	echo "Pushing to Subtree databases/transactions-database/Mysql-TypeORM-Typescript at branch $(BRANCH)"
	git subtree push --prefix=databases/transactions-database/Mysql-TypeORM-Typescript https://github.com/arsalanator/transactions-database-for-appointment-system-with-Mysql-TypeORM-Typescript $(BRANCH)

# push-to-content-database-subtree
# make BRANCH=installing-databases push-to-content-database-subtree
push-to-content-database-subtree:
	echo "Pushing to Subtree databases/content-database/Mongodb-Mongoose-Typescript at branch $(BRANCH)"
	git subtree push --prefix=databases/content-database/Mongodb-Mongoose-Typescript https://github.com/arsalanator/content-database-for-appointment-system-with-Mongodb-Mongoose-Typescript $(BRANCH)

# push-to-cache-database-subtree
# make BRANCH=installing-databases push-to-cache-database-subtree
push-to-cache-database-subtree:
	echo "Pushing to Subtree databases/cache-database/Redis-IOredis-Typescript at branch $(BRANCH)"
	git subtree push --prefix=databases/cache-database/Redis-IOredis-Typescript https://github.com/arsalanator/cache-database-for-appointment-system-with-Redis-IOredis-Typescript $(BRANCH)

# push to backend subtree
# make BRANCH=project-bootstrapping push-to-backend-subtree
push-to-backend-subtree:
	echo "Pushing to Subtree user-facing-backend/Express-Typescipt at branch $(BRANCH)"
	git subtree push --prefix=user-facing-backend/Express-Typescipt https://github.com/arsalanator/user-facing-backend-for-appointment-system-with-Express-Typescipt $(BRANCH)

# push to frontend subtree
# make BRANCH=project-bootstrapping push-to-frontend-subtree
push-to-frontend-subtree:
	echo "Pushing to Subtree user-facing-frontend/React-Typescipt at branch $(BRANCH)"
	git subtree push --prefix=user-facing-frontend/React-Typescipt https://github.com/arsalanator/user-facing-frontend-for-appointment-system-with-React-Typescipt $(BRANCH)

# generating a zip file of project
generate-project-rar-file:
	echo "Generating project .rar file"
	rm -rf current_app_state.zip && zip -r current_app_state.zip . -x "user-facing-backend/Express-Typescipt/node_modules/*" "user-facing-frontend/React-Typescipt/node_modules/*" "databases/transactions-database/Mysql-TypeORM-Typescript/node_modules/*" "databases/content-database/Mongodb-Mongoose-Typescript/node_modules/*" "databases/cache-database/Redis-IOredis-Typescript/node_modules/*"

# Frontend tasks
install-frontend:
	cd $(FRONTEND_DIR) && npm install

start-frontend:
	cd $(FRONTEND_DIR) && npm start

build-frontend:
	cd $(FRONTEND_DIR) && npm run build

test-frontend:
	cd $(FRONTEND_DIR) && npm test

# Backend tasks
install-backend:
	cd $(BACKEND_DIR) && npm install

start-backend:
	cd $(BACKEND_DIR) && npm run dev

build-backend:
	cd $(BACKEND_DIR) && npm run build

test-backend:
	cd $(BACKEND_DIR) && npm test

# Docker tasks
build-docker:
	docker build -t $(DOCKER_IMAGE):latest .

push-docker:
	docker tag $(DOCKER_IMAGE):latest $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):latest
	docker push $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):latest

# Docker Compose
docker-compose-up:
	docker-compose up --build -d

docker-compose-down:
	docker-compose down

# Kubernetes (Minikube)
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

# Combined tasks
install-all: install-frontend install-backend

start-all: start-frontend start-backend

build-all: build-frontend build-backend build-docker

test-all: test-frontend test-backend

deploy-all:
	make docker-compose-up
	make k8s-deploy

clean:
	rm -rf $(FRONTEND_DIR)/node_modules $(BACKEND_DIR)/node_modules
	rm -rf $(FRONTEND_DIR)/build $(BACKEND_DIR)/dist

lint-frontend:
	cd $(FRONTEND_DIR) && npm run lint

lint-backend:
	cd $(BACKEND_DIR) && npm run lint

lint-all: lint-frontend lint-backend