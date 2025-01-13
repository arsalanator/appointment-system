# Help target
list-ansible-commands:
	@echo "Available targets:"
	@echo "  mongodb    - Deploy MongoDB only"
	@echo "  redis      - Deploy Redis only"
	@echo "  mysql      - Deploy MySQL only"
	@echo "  all        - Deploy all databases"
	@echo "  delete-all-databases      - Remove all databases"
	@echo "  validate   - Validate Ansible playbook"
	@echo "  help       - Show this help message"
	@echo ""
	@echo "Usage examples:"
	@echo "  make mongodb          - Deploy MongoDB"
	@echo "  make redis            - Deploy Redis"
	@echo "  make mysql            - Deploy MySQL"
	@echo "  make delete-all-databases            - Remove all databases"
	@echo "  sudo make mongodb     - Deploy MongoDB with sudo"
	@echo ""
	@echo "Note: Most commands require sudo privileges"
	@echo "Usage with tags:"
	@echo "  make mongodb ANSIBLE_TAGS=config          - Deploy MongoDB with config tasks only"
	@echo "  make redis ANSIBLE_TAGS=service           - Deploy Redis with service tasks only"
	@echo "  make mysql ANSIBLE_TAGS='config,service'  - Deploy MySQL with both config and service tasks"
	@echo "  sudo make all-db            - Deploy all databases"
	@echo "  sudo make setup-deploy-docker - Setup only Docker on deployment server"

# Default target
.DEFAULT_GOAL := list-ansible-commands

# Check if running with sudo
check-sudo:
	@if [ "$(shell id -u)" != "0" ]; then \
		echo "Please run with sudo privileges"; \
		exit 1; \
	fi

# Validate Ansible playbook
validate:
	@echo "Validating Ansible playbook..."
	ansible-playbook $(PLAYBOOK) --syntax-check -i $(INVENTORY)

# Install Ansible if not present
ensure-ansible:
	@if ! command -v ansible >/dev/null 2>&1; then \
		echo "Installing Ansible..."; \
		apt update && apt install -y ansible; \
	fi

# Base setup target
setup: check-sudo ensure-ansible validate

# Individual database targets
.PHONY: mongodb redis mysql all delete-all-databases validate setup

mongodb: setup
	@echo "Deploying MongoDB..."
	ansible-playbook $(PLAYBOOK) -i $(INVENTORY) --tags "mongodb,$(ANSIBLE_TAGS)" $(VERBOSE)

redis: setup
	@echo "Deploying Redis..."
	ansible-playbook $(PLAYBOOK) -i $(INVENTORY) --tags "redis,$(ANSIBLE_TAGS)" $(VERBOSE)

mysql: setup
	@echo "Deploying MySQL..."
	ansible-playbook $(PLAYBOOK) -i $(INVENTORY) --tags "mysql,$(ANSIBLE_TAGS)" $(VERBOSE)

# Deploy all databases with optional extra tags
# all-db: setup
# 	@echo "Deploying all databases..."
# 	ansible-playbook $(PLAYBOOK) -i $(INVENTORY) $(if $(ANSIBLE_TAGS),--tags "$(ANSIBLE_TAGS)") $(VERBOSE)

# Deploy all databases
all-db: setup
	@echo "Deploying all databases..."
	ansible-playbook $(PLAYBOOK) -i $(INVENTORY) --limit databases $(VERBOSE)

setup-deploy: setup
	@echo "Setting up deployment server..."
	ansible-playbook $(PLAYBOOK) -i $(INVENTORY) --limit deployment $(VERBOSE)

setup-deploy-docker: setup
	@echo "Setting up Docker on deployment server..."
	ansible-playbook $(PLAYBOOK) -i $(INVENTORY) --limit deployment --tags docker $(VERBOSE)

setup-deploy-node: setup
	@echo "Setting up Node.js on deployment server..."
	ansible-playbook $(PLAYBOOK) -i $(INVENTORY) --limit deployment --tags node $(VERBOSE)

# delete-all-databases target for removing all databases
delete-all-databases: setup
	@echo "Removing all databases..."
	ansible-playbook $(PLAYBOOK) -i $(INVENTORY) --tags cleanup $(VERBOSE)