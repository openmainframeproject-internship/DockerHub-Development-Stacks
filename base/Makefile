VERSION=$(shell cat VERSION)

all:	base

base:	sles-15-docker.tar.xz Dockerfile
	docker build --rm --tag vedarth/sles --label VERSION=$(VERSION) . 

sles-15-docker.tar.xz:	config.sh
	./config.sh

push:
	docker tag sles/sles:latest sles/sles:sles15
	docker tag sles/sles:latest sles/sles:$(VERSION)
	docker tag sles/sles:latest sles:sles7
	docker push sles/sles:latest
	docker push sles/sles:sles7
	docker push sles/sles:$(VERSION)

clean:
	rm -f sles-15-docker.tar.xz
	docker rmi sles/sles:latest || true
	docker rmi sles/sles:sles15 || true
	docker rmi sles/sles:$(VERSION) || true
