# Add these to your existing help target
list-firebase-commands:
	@echo "Firebase Commands:"
	@echo "  make firebase-init              - Initialize Firebase projects and configurations"
	@echo "  make firebase-deploy-staging    - Deploy all services to Firebase staging"
	@echo "  make firebase-deploy-prod       - Deploy all services to Firebase production"
	@echo "  make firebase-deploy-all        - Deploy to all Firebase environments"
	@echo "  make deploy-database-staging    - Deploy only database rules to staging"
	@echo "  make deploy-database-prod       - Deploy only database rules to production"
	@echo "  make deploy-fcm-staging         - Deploy only FCM to staging"
	@echo "  make deploy-fcm-prod           - Deploy only FCM to production"
	@echo "  make firebase-login             - Login to Firebase CLI"

# Default target
.DEFAULT_GOAL := list-firebase-commands

.PHONY: check-firebase firebase-login firebase-init \
        firebase-deploy-staging firebase-deploy-prod firebase-deploy-all \
        init-database init-fcm deploy-database deploy-fcm

# Check and install Firebase CLI if needed
check-firebase:
	@if ! command -v firebase >/dev/null 2>&1; then \
		echo "Installing Firebase CLI..."; \
		npm install -g firebase-tools; \
	fi

# Login to Firebase
firebase-login: check-firebase
	@echo "Logging into Firebase..."
	firebase login

# Create database rules
create-database-rules:
	@echo "Creating database rules..."
	@echo '{\
		"rules": {\
			".read": "auth != null",\
			".write": "auth != null",\
			"users": {\
				"$uid": {\
					".read": "auth != null && auth.uid == $uid",\
					".write": "auth != null && auth.uid == $uid"\
				}\
			},\
			"public": {\
				".read": true,\
				".write": "auth != null"\
			}\
		}\
	}' > $(DATABASE_RULES_PATH)

# Initialize Firebase Staging
init-firebase-staging: firebase-login create-database-rules
	@echo "Initializing Firebase Staging project..."
	@firebase projects:create $(STAGING_PROJECT_ID) --display-name="Your App Staging" || true
	@firebase use $(STAGING_PROJECT_ID)
	@firebase database:instances:create default --region us-central1 || true
	@firebase target:apply hosting staging $(BUILD_PATH)
	@firebase target:apply database staging default
	@firebase deploy --only database:rules

# Initialize Firebase Production
init-firebase-prod: firebase-login create-database-rules
	@echo "Initializing Firebase Production project..."
	@firebase projects:create $(PROD_PROJECT_ID) --display-name="Your App Production" || true
	@firebase use $(PROD_PROJECT_ID)
	@firebase database:instances:create default --region us-central1 || true
	@firebase target:apply hosting production $(BUILD_PATH)
	@firebase target:apply database production default
	@firebase deploy --only database:rules

# Initialize FCM for both environments
init-fcm: firebase-login
	@echo "Initializing Firebase Cloud Messaging..."
	@# Staging FCM setup
	@firebase use $(STAGING_PROJECT_ID)
	@firebase functions:config:set fcm.server_key="$(shell firebase apps:sdks:web)" || true
	@# Production FCM setup
	@firebase use $(PROD_PROJECT_ID)
	@firebase functions:config:set fcm.server_key="$(shell firebase apps:sdks:web)" || true

# Create Firebase configurations
create-firebase-configs:
	@echo "Creating Firebase configurations..."
	@echo '{\
		"projects": {\
			"staging": "$(STAGING_PROJECT_ID)",\
			"production": "$(PROD_PROJECT_ID)"\
		},\
		"targets": {\
			"$(STAGING_PROJECT_ID)": {\
				"hosting": {\
					"staging": ["$(BUILD_PATH)"]\
				},\
				"database": {\
					"staging": ["default"]\
				}\
			},\
			"$(PROD_PROJECT_ID)": {\
				"hosting": {\
					"production": ["$(BUILD_PATH)"]\
				},\
				"database": {\
					"production": ["default"]\
				}\
			}\
		}\
	}' > deployments/firebase/.firebaserc
	@echo '{\
		"hosting": [\
			{\
				"target": "staging",\
				"public": "$(BUILD_PATH)",\
				"ignore": ["firebase.json", "**/.*", "**/node_modules/**"],\
				"rewrites": [{"source": "**", "destination": "/index.html"}]\
			},\
			{\
				"target": "production",\
				"public": "$(BUILD_PATH)",\
				"ignore": ["firebase.json", "**/.*", "**/node_modules/**"],\
				"rewrites": [{"source": "**", "destination": "/index.html"}]\
			}\
		],\
		"database": {\
			"rules": "$(DATABASE_RULES_PATH)"\
		},\
		"fcm": {\
			"messaging": {\
				"serverKey": "$(FCM_SERVER_KEY_PATH)"\
			}\
		}\
	}' > deployments/firebase/firebase.json

# Initialize all Firebase projects and configurations
firebase-init: init-firebase-staging init-firebase-prod init-fcm create-firebase-configs
	@echo "Firebase initialization complete!"

# Deploy database rules to staging
deploy-database-staging: check-firebase
	@echo "Deploying database rules to staging..."
	firebase use $(STAGING_PROJECT_ID)
	firebase deploy --only database

# Deploy database rules to production
deploy-database-prod: check-firebase
	@echo "Deploying database rules to production..."
	firebase use $(PROD_PROJECT_ID)
	firebase deploy --only database

# Deploy FCM configuration to staging
deploy-fcm-staging: check-firebase
	@echo "Deploying FCM configuration to staging..."
	firebase use $(STAGING_PROJECT_ID)
	firebase deploy --only functions:messaging

# Deploy FCM configuration to production
deploy-fcm-prod: check-firebase
	@echo "Deploying FCM configuration to production..."
	firebase use $(PROD_PROJECT_ID)
	firebase deploy --only functions:messaging

# Build frontend
build-frontend:
	@echo "Building frontend..."
	cd $(FRONTEND_PATH) && npm run build

# Deploy to staging (all services)
firebase-deploy-staging: check-firebase build-frontend deploy-database-staging deploy-fcm-staging
	@echo "Deploying all services to Firebase Staging..."
	firebase use $(STAGING_PROJECT_ID)
	firebase deploy --only hosting:staging

# Deploy to production (all services)
firebase-deploy-prod: check-firebase build-frontend deploy-database-prod deploy-fcm-prod
	@echo "Deploying all services to Firebase Production..."
	firebase use $(PROD_PROJECT_ID)
	firebase deploy --only hosting:production

# Deploy to all environments
firebase-deploy-all: firebase-deploy-staging firebase-deploy-prod
	@echo "Deployed to all Firebase environments"