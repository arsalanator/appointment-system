list-docker-commands:
	@echo "	make build-docker"
	@echo "	make push-docker"
	@echo "	make docker-compose-up"
	@echo "	make docker-compose-down"

build-docker:
	docker build -t $(DOCKER_IMAGE):latest .

push-docker:
	docker tag $(DOCKER_IMAGE):latest $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):latest
	docker push $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):latest

docker-compose-up:
	docker-compose up --build -d

docker-compose-down:
	docker-compose down