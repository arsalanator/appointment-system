# Root level Makefile
SHELL := /bin/bash
ROOT_DIR := $(shell pwd)

# Dynamic include of all .mk files from makefiles directory
MAKEFILE_DIR := $(ROOT_DIR)/makefiles
MK_FILES := $(wildcard $(MAKEFILE_DIR)/*.mk)
include $(MK_FILES)


FRONTEND_DIR := user-facing-frontend
BACKEND_DIR := user-facing-backend
USER_FACING_FRONTEND_DIR := $(FRONTEND_DIR)/React-Typescipt
USER_FACING_BACKEND_DIR := $(BACKEND_DIR)/Express-Typescipt
CACHE_DB_DIR := databases/cache-database/Redis-IOredis-Typescript
CONTENT_DB_DIR := databases/content-database/Mongodb-Mongoose-Typescript
TRANSACTION_DB_DIR := databases/transactions-database/Mysql-TypeORM-Typescript
DOCKER_IMAGE := appointment-system
DOCKER_REGISTRY := your-docker-registry # Replace with actual registry
K8S_NAMESPACE := appointment-system
ENV_FILE := .env

# Subtree paths
FRONTEND_PREFIX := user-facing-frontend/React-Typescipt
BACKEND_PREFIX := user-facing-backend/Express-Typescipt
CACHE_DB_PREFIX := databases/cache-database/Redis-IOredis-Typescript
CONTENT_DB_PREFIX := databases/content-database/Mongodb-Mongoose-Typescript
TRANSACTIONS_DB_PREFIX := databases/transactions-database/Mysql-TypeORM-Typescript

# Remote urls
FRONTEND_REMOTE_URL := https://github.com/arsalanator/user-facing-frontend-for-appointment-system-with-React-Typescipt
BACKEND_REMOTE_URL := https://github.com/arsalanator/user-facing-backend-for-appointment-system-with-Express-Typescipt
CACHE_DB_REMOTE_URL := https://github.com/arsalanator/cache-database-for-appointment-system-with-Redis-IOredis-Typescript
CONTENT_DB_REMOTE_URL := https://github.com/arsalanator/content-database-for-appointment-system-with-Mongodb-Mongoose-Typescript
TRANSACTIONS_DB_REMOTE_URL := https://github.com/arsalanator/transactions-database-for-appointment-system-with-Mysql-TypeORM-Typescript


# Collection of all prefixes and their corresponding remotes
SUBTREES := $(FRONTEND_PREFIX):$(FRONTEND_REMOTE_URL) \
            $(BACKEND_PREFIX):$(BACKEND_REMOTE_URL) \
            $(CACHE_DB_PREFIX):$(CACHE_DB_REMOTE_URL) \
            $(CONTENT_DB_PREFIX):$(CONTENT_DB_REMOTE_URL) \
            $(TRANSACTIONS_DB_PREFIX):$(TRANSACTIONS_DB_REMOTE_URL)

# Default branch names
DEFAULT_BRANCH := main
DEFAULT_SUBTREE_BRANCH := main



# Export all variables to sub-makes
export

.PHONY: help list

help:
	@echo "Usage:"
	@echo "  make <command> [arguments]"
	@echo "\nExample:"
	@echo "  make git-sync branch=feature/new-feature"
	@echo "  make docker-up"
	@echo "\nRun 'make list' to see all available commands"

list:
	@echo "Available commands:"
	@echo ""
	make list-app-scripts-commands
	@echo ""
	make list-code-cleanup-commands
	@echo ""
	make list-deploy-commands
	@echo ""
	make list-docker-commands
	@echo ""
	make list-git-commands
	@echo ""
	make list-k8-commands