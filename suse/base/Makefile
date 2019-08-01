VERSION=$(shell cat VERSION)

all:	base

base:	sles-15-docker.tar.xz Dockerfile
	docker build --rm --tag vedarth/sles --label VERSION=$(VERSION) .
	
sles-15-docker.tar.xz:	config.sh
	./config.sh

push:
	docker push sles/sles:latest
	docker push sles/sles:sles15
	docker push sles/sles:$(VERSION)

clean:
	rm -f sles-15-docker.tar.xz
	docker rmi vedarth/sles:latest || true