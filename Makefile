BUILD_NAME := genv/lighthouse
BUILD_DATE := $(shell date -u "+%Y%m%dT%H%M%SZ")
BUILD_VERSION := $(shell npm show lighthouse version)

build: docker-build push
.PHONY: build

docker-build:
	docker build \
		--no-cache \
		-t $(BUILD_NAME):$(BUILD_VERSION) \
		-t $(BUILD_NAME):$(BUILD_VERSION)-$(BUILD_DATE) \
		-t $(BUILD_NAME):latest \
	.;
.PHONY: docker-build
.SILENT: docker-build

push:
	docker push $(BUILD_NAME):$(BUILD_VERSION); \
	docker push $(BUILD_NAME):$(BUILD_VERSION)-$(BUILD_DATE); \
	docker push $(BUILD_NAME):latest;
.PHONY: push
.SILENT: push

test:
	docker run -ti $(BUILD_NAME):$(BUILD_VERSION) --version;
.PHONY: test
.SILENT: test
