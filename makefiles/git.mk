list-git-commands:
	@echo "	make BRANCH=\"set-branch-here\" pull-from-all-subtrees" - 
	@echo "	make BRANCH=\"set-branch-here\" pull-from-backend-subtree" - 
	@echo "	make BRANCH=\"set-branch-here\" pull-from-frontend-subtree" - 
	@echo "	make BRANCH=\"set-branch-here\" pull-from-cache-database-subtree" - 
	@echo "	make BRANCH=\"set-branch-here\" pull-from-transaction-database-subtreee" - 
	@echo "	make BRANCH=\"set-branch-here\" pull-from-content-database-subtree" - 
	@echo "	make BRANCH=\"set-branch-here\" push-to-all-subtrees" - 
	@echo "	make BRANCH=\"set-branch-here\" push-to-all-database-subtrees" - 
	@echo "	make BRANCH=\"set-branch-here\" push-to-user-facing-frontends-and-backends-subtrees" - 
	@echo "	make BRANCH=\"set-branch-here\" push-to-transaction-database-subtree" - 
	@echo "	make BRANCH=\"set-branch-here\" push-to-content-database-subtree" - 
	@echo "	make BRANCH=\"set-branch-here\" push-to-cache-database-subtree" - 
	@echo "	make BRANCH=\"set-branch-here\" push-to-backend-subtree" - 
	@echo "	make BRANCH=\"set-branch-here\" push-to-frontend-subtree" - 
	@echo " make NEW_BRANCH=branch-name sync-all-and-start-new-work - Pull all updates and create new branch"
	@echo " make sync-parent - Pull from parent repo only"
	@echo " make sync-subtrees - Pull from all subtree repos"
	@echo " make NEW_BRANCH=branch-name create-branch - Create and checkout new branch"
	@echo " make sync-user-facing-frontend - Create and checkout new branch"
	@echo " make sync-user-facing-backend - Create and checkout new branch"
	@echo " make sync-cache-db - Create and checkout new branch"
	@echo " make sync-content-db - Create and checkout new branch"
	@echo " make sync-transactions-db - Create and checkout new branch"



.PHONY: help sync-all-and-start-new-work sync-parent sync-subtrees create-branch

# File to store staged subtrees
STAGED_SUBTREES_FILE := .staged_subtrees.tmp
 

# Pull everything and create new branch
sync-all-and-start-new-work:
	@echo "Checking out on $(DEFAULT_BRANCH_FOR_PARENT) branch for pulling from parent and all subtrees ..."
	@git checkout $(DEFAULT_BRANCH_FOR_PARENT) 
	@$(MAKE) sync-parent 
	@$(MAKE) sync-subtrees
	@read -p "Enter new branch name where you want to work: " enteredBranchName; \
	echo "Going to create branch with name $$enteredBranchName ..."; \
	$(MAKE) create-branch BRANCH=$$enteredBranchName

# Pull from parent repo
sync-parent:
	@echo "Pulling from parent repository..."
	@git pull origin $(DEFAULT_BRANCH_FOR_PARENT)

# Pull from all subtrees
sync-subtrees:
	@echo "Pulling from all subtree repositories..."
	@for subtree in $(SUBTREES); do \
		PREFIX=$$(echo $$subtree | cut -d_ -f1); \
		REMOTE_URL=$$(echo $$subtree | cut -d_ -f2); \
		echo "Pulling from $$REMOTE_URL for $$PREFIX..."; \
		git subtree pull --prefix=$$PREFIX $$REMOTE_URL $(DEFAULT_SUBTREE_BRANCH) --squash; \
	done

# Create and checkout new branch
create-branch:
	@echo "Creating new branch: $(BRANCH)"
	@git checkout -b $(BRANCH)
	@echo "Now on branch: $(BRANCH)"

# Individual subtree sync targets
sync-user-facing-frontend:
	@echo "Pulling repo subtree..."
	@git subtree pull --prefix=$(FRONTEND_PREFIX) $(FRONTEND_REMOTE_URL) $(DEFAULT_SUBTREE_BRANCH) --squash

sync-user-facing-backend:
	@echo "Pulling backend subtree..."
	@git subtree pull --prefix=$(BACKEND_PREFIX) $(BACKEND_REMOTE_URL) $(DEFAULT_SUBTREE_BRANCH) --squash

sync-cache-db:
	@echo "Pulling cache database subtree..."
	@git subtree pull --prefix=$(CACHE_DB_PREFIX) $(CACHE_DB_REMOTE_URL) $(DEFAULT_SUBTREE_BRANCH) --squash

sync-content-db:
	@echo "Pulling content database subtree..."
	@git subtree pull --prefix=$(CONTENT_DB_PREFIX) $(CONTENT_DB_REMOTE_URL) $(DEFAULT_SUBTREE_BRANCH) --squash

sync-transactions-db:
	@echo "Pulling transactions database subtree..."
	@git subtree pull --prefix=$(TRANSACTIONS_DB_PREFIX) $(TRANSACTIONS_DB_REMOTE_URL) $(DEFAULT_SUBTREE_BRANCH) --squash











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

# make BRANCH=installing-databases push-to-transaction-database-subtree
push-to-transaction-database-subtree:
	echo "Pushing to Subtree databases/transactions-database/Mysql-TypeORM-Typescript at branch $(BRANCH)"
	git subtree push --prefix=databases/transactions-database/Mysql-TypeORM-Typescript https://github.com/arsalanator/transactions-database-for-appointment-system-with-Mysql-TypeORM-Typescript $(BRANCH)

# make BRANCH=installing-databases push-to-content-database-subtree
push-to-content-database-subtree:
	echo "Pushing to Subtree databases/content-database/Mongodb-Mongoose-Typescript at branch $(BRANCH)"
	git subtree push --prefix=databases/content-database/Mongodb-Mongoose-Typescript https://github.com/arsalanator/content-database-for-appointment-system-with-Mongodb-Mongoose-Typescript $(BRANCH)

# make BRANCH=installing-databases push-to-cache-database-subtree
push-to-cache-database-subtree:
	echo "Pushing to Subtree databases/cache-database/Redis-IOredis-Typescript at branch $(BRANCH)"
	git subtree push --prefix=databases/cache-database/Redis-IOredis-Typescript https://github.com/arsalanator/cache-database-for-appointment-system-with-Redis-IOredis-Typescript $(BRANCH)

# make BRANCH=project-bootstrapping push-to-backend-subtree
push-to-backend-subtree:
	echo "Pushing to Subtree user-facing-backend/Express-Typescipt at branch $(BRANCH)"
	git subtree push --prefix=user-facing-backend/Express-Typescipt https://github.com/arsalanator/user-facing-backend-for-appointment-system-with-Express-Typescipt $(BRANCH)

# make BRANCH=project-bootstrapping push-to-frontend-subtree
push-to-frontend-subtree:
	echo "Pushing to Subtree user-facing-frontend/React-Typescipt at branch $(BRANCH)"
	git subtree push --prefix=user-facing-frontend/React-Typescipt $(BRANCH)



interactively-ask-for-files-to-add:
	@bash -c 'CURRENT_BRANCH=$$(git branch --show-current); \
	echo "Current branch: $$CURRENT_BRANCH"; \
	read -p "Do you want to proceed as this will push to '$$CURRENT_BRANCH' branch ? (y/n) " answer; \
	if [[ "$$answer" != "y" ]]; then \
		echo "Aborting..."; \
		exit 1; \
	fi; \
	rm -f .staged_subtrees.tmp; \
	\
	for subtree in $(SUBTREES); do \
		PREFIX=$${subtree%%:*}; \
		REMOTE=$${subtree#*:}; \
		echo -e "\nChecking $$PREFIX..."; \
		\
		CHANGES=$$(git status --porcelain "$$PREFIX"); \
		if [[ ! -z "$$CHANGES" ]]; then \
			echo "Changes found in $$PREFIX at '$$CURRENT_BRANCH' branch:"; \
			echo "$$CHANGES"; \
			read -p "Enter space-separated file paths to stage (or skip): " files; \
			if [[ "$$files" != "skip" && ! -z "$$files" ]]; then \
				echo $$files; \
				git add $$files; \
				echo "$$PREFIX:$$REMOTE" >> .staged_subtrees.tmp; \
				read -p "Enter commit message for $$PREFIX: " msg; \
				git commit -m "$$PREFIX: $$msg"; \
				read -p "Do you want to push to main repo at $$CURRENT_BRANCH (or skip): " isPushRequiredAtMainRepo; \
				if [[ "$$isPushRequiredAtMainRepo" != "skip" && ! -z "$$isPushRequiredAtMainRepo" ]]; then \
					echo -e "\nPushing this commit to root repo at '$$CURRENT_BRANCH' branch..."; \
					git push origin "$$CURRENT_BRANCH"; \
				fi; \
				read -p "Do you want to push to $$PREFIX at $$CURRENT_BRANCH (or skip): " isPushRequiredAtCurrentSubtree; \
				if [[ "$$isPushRequiredAtCurrentSubtree" != "skip" && ! -z "$$isPushRequiredAtCurrentSubtree" ]]; then \
					echo "Pushing this commit to $$PREFIX at '$$CURRENT_BRANCH' branch to $$REMOTE..."; \
					git subtree push --prefix="$$PREFIX" "$$REMOTE" $$CURRENT_BRANCH; \
				fi; \
			fi; \
		else \
			echo "No changes in $$PREFIX at $$CURRENT_BRANCH branch"; \
		fi; \
	done; \
	\
	echo -e "\nChecking root directory..."; \
	SUBTREE_PATHS=$$(echo "$(SUBTREES)" | tr " " "\n" | cut -d_ -f1 | paste -sd"|" -); \
	ROOT_CHANGES=$$(git status --porcelain | grep -vE "^..($$SUBTREE_PATHS)"); \
	if [[ ! -z "$$ROOT_CHANGES" ]]; then \
		echo "Changes found in root at $$CURRENT_BRANCH branch:"; \
		echo "$$ROOT_CHANGES"; \
		read -p "Enter space-separated file paths to stage (or skip): " root_files; \
		if [[ "$$root_files" != "skip" && ! -z "$$root_files" ]]; then \
			git add $$root_files; \
			read -p "Enter commit message for root: " root_msg; \
			git commit -m "root: $$root_msg"; \
			read -p "Do you want to push changes at main repo at $$CURRENT_BRANCH (or skip): " isPushRequiredAtMainRepoForRootChanges; \
			if [[ "$$isPushRequiredAtMainRepoForRootChanges" != "skip" && ! -z "$$isPushRequiredAtMainRepoForRootChanges" ]]; then \
				echo -e "\nPushing to root repo at $$CURRENT_BRANCH branch..."; \
				git push origin "$$CURRENT_BRANCH"; \
			fi; \
		fi; \
	else \
		echo "No changes in root directory at $$CURRENT_BRANCH branch"; \
	fi'