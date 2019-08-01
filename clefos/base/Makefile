VERSION=$(shell cat VERSION)

all:	base

base:	clefos-7-docker.tar.xz Dockerfile
	docker build --rm --tag clefos/clefos --label VERSION=$(VERSION) . 

clefos-7-docker.tar.xz:	createBase.sh
	./createBase.sh

push:
	docker tag clefos/clefos:latest clefos:latest
	docker tag clefos/clefos:latest clefos/clefos:$(VERSION)
	docker tag clefos/clefos:latest clefos:clefos7
	docker push clefos/clefos:latest
	docker push clefos:latest
	docker push clefos/clefos:$(VERSION)

clean:
	rm -f clefos-7-docker.tar.xz
	docker rmi clefos/clefos:latest || true
	docker rmi clefos:latest || true
	docker rmi clefos/clefos:$(VERSION) || true
