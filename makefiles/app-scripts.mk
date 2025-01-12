list-app-scripts-commands:
	@echo "	make install-all"
	@echo "	make start-all"
	@echo "	make build-all"
	@echo "	make test-all"
	@echo "	make install-frontend"
	@echo "	make start-frontend"
	@echo "	make build-frontend"
	@echo "	make test-frontend"
	@echo "	make install-backend"
	@echo "	make start-backend"
	@echo "	make build-backend"
	@echo "	make test-backend"
	@echo "	make generate-project-rar-file"

# Combined tasks
install-all: install-frontend install-backend

start-all: start-frontend start-backend

build-all: build-frontend build-backend build-docker

test-all: test-frontend test-backend


# Frontend tasks
install-frontend:
	cd $(USER_FACING_FRONTEND_DIR) && npm install

start-frontend:
	cd $(USER_FACING_FRONTEND_DIR) && npm start

build-frontend:
	cd $(USER_FACING_FRONTEND_DIR) && npm run build

test-frontend:
	cd $(USER_FACING_FRONTEND_DIR) && npm test

# Backend tasks
install-backend:
	cd $(USER_FACING_BACKEND_DIR) && npm install

start-backend:
	cd $(USER_FACING_BACKEND_DIR) && npm run dev

build-backend:
	cd $(USER_FACING_BACKEND_DIR) && npm run build

test-backend:
	cd $(USER_FACING_BACKEND_DIR) && npm test


# generating a zip file of project
generate-project-rar-file:
	echo "Generating project .rar file"
	rm -rf current_app_state.zip && zip -r current_app_state.zip . -x "$(USER_FACING_BACKEND_DIR)/node_modules/*" "$(USER_FACING_FRONTEND_DIR)/node_modules/*" "$(CACHE_DB_DIR)/node_modules/*" "$(CONTENT_DB_DIR)/node_modules/*" "$(TRANSACTION_DB_DIR)/node_modules/*"