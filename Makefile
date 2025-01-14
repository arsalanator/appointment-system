# Root level Makefile
SHELL := /bin/bash
ROOT_DIR := $(shell pwd)

# Dynamic include of all .mk files from makefiles directory
MAKEFILE_DIR := $(ROOT_DIR)/makefiles
MK_FILES := $(wildcard $(MAKEFILE_DIR)/*.mk)
include $(MK_FILES)

# terminal output color related vars
GREEN = \033[0;32m
NC = \033[0m  # No Color

# env related vars
ENV_FILE := .env

# git related vars
FRONTEND_DIR := user-facing-frontend
BACKEND_DIR := user-facing-backend
USER_FACING_FRONTEND_DIR := $(FRONTEND_DIR)/React-Typescipt
USER_FACING_BACKEND_DIR := $(BACKEND_DIR)/Express-Typescipt
CACHE_DB_DIR := databases/cache-database/Redis-IOredis-Typescript
CONTENT_DB_DIR := databases/content-database/Mongodb-Mongoose-Typescript
TRANSACTION_DB_DIR := databases/transactions-database/Mysql-TypeORM-Typescript

FRONTEND_PREFIX := user-facing-frontend/React-Typescipt
BACKEND_PREFIX := user-facing-backend/Express-Typescipt
CACHE_DB_PREFIX := databases/cache-database/Redis-IOredis-Typescript
CONTENT_DB_PREFIX := databases/content-database/Mongodb-Mongoose-Typescript
TRANSACTIONS_DB_PREFIX := databases/transactions-database/Mysql-TypeORM-Typescript

FRONTEND_REMOTE_URL := "https://github.com/arsalanator/user-facing-frontend-for-appointment-system-with-React-Typescipt"
BACKEND_REMOTE_URL := "https://github.com/arsalanator/user-facing-backend-for-appointment-system-with-Express-Typescipt"
CACHE_DB_REMOTE_URL := "https://github.com/arsalanator/cache-database-for-appointment-system-with-Redis-IOredis-Typescript"
CONTENT_DB_REMOTE_URL := "https://github.com/arsalanator/content-database-for-appointment-system-with-Mongodb-Mongoose-Typescript"
TRANSACTIONS_DB_REMOTE_URL := "https://github.com/arsalanator/transactions-database-for-appointment-system-with-Mysql-TypeORM-Typescript"

SUBTREES := $(FRONTEND_PREFIX)_$(FRONTEND_REMOTE_URL) \
            $(BACKEND_PREFIX)_$(BACKEND_REMOTE_URL) \
            $(CACHE_DB_PREFIX)_$(CACHE_DB_REMOTE_URL) \
            $(CONTENT_DB_PREFIX)_$(CONTENT_DB_REMOTE_URL) \
            $(TRANSACTIONS_DB_PREFIX)_$(TRANSACTIONS_DB_REMOTE_URL)

DEFAULT_BRANCH_FOR_PARENT := main
DEFAULT_SUBTREE_BRANCH := main

# ansible related vars
ANSIBLE_PATH := deployments/ansible
INVENTORY := $(ANSIBLE_PATH)/inventory
PLAYBOOK := $(ANSIBLE_PATH)/site.yml
VERBOSE := -v
ANSIBLE_TAGS := 

# firebase related vars
STAGING_PROJECT_ID := your-app-staging
PROD_PROJECT_ID := your-app-prod
FRONTEND_PATH := user-facing-frontend/React-Typescript
BUILD_PATH := $(FRONTEND_PATH)/build
DATABASE_RULES_PATH := deployments/firebase/database.rules.json
FCM_SERVER_KEY_PATH := deployments/firebase/fcm-server-key.json

# aws related vars
AWS_CLOUD_FORMATION_STACK_NAME := compute:ec2--storage:s3-ebs--network:iam-eip

# docker related vars
DOCKER_IMAGE := appointment-system
DOCKER_REGISTRY := your-docker-registry # Replace with actual registry

# kubernetes related vars
K8S_NAMESPACE := appointment-system

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