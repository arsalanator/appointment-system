list-code-cleanup-commands:
	@echo "	make clean"
	@echo "	make lint-frontend"
	@echo "	make lint-backend"
	@echo "	make lint-all"
	@echo "	make run-lint"
	@echo "	make run-lint-fix"
	@echo "	make run-prettier-format"
	@echo "	make run-prettier-format-check"
	@echo "	make run-lint-and-prettier-format-check"
	@echo "	make run-lint-fix-and-prettier-format-check"
	@echo "	make run-lint-on-all"
	@echo "	make run-lint-fix-on-all"
	@echo "	make run-prettier-format-on-all"
	@echo "	make run-prettier-format-check-on-all"
	@echo "	make run-lint-and-prettier-format-check-on-all"
	@echo "	make run-lint-fix-and-prettier-format-check-on-all"

clean:
	rm -rf $(FRONTEND_DIR)/node_modules $(BACKEND_DIR)/node_modules
	rm -rf $(FRONTEND_DIR)/build $(BACKEND_DIR)/dist

lint-frontend:
	cd $(FRONTEND_DIR) && npm run lint

lint-backend:
	cd $(BACKEND_DIR) && npm run lint

lint-all: lint-frontend lint-backend


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