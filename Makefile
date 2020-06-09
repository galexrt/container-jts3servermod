RELEASE_TAG := v$(shell date +%Y%m%d-%H%M%S-%3N)

build:
	docker build -t galexrt/jts3servermod:latest .

release:
	git tag $(RELEASE_TAG)
	git push origin $(RELEASE_TAG)

release-and-build: build
	git tag $(RELEASE_TAG)
	docker tag galexrt/jts3servermod:latest galexrt/jts3servermod:$(RELEASE_TAG)
	git push origin $(RELEASE_TAG)
	docker push galexrt/jts3servermod:$(RELEASE_TAG)
	docker push galexrt/jts3servermod:latest
