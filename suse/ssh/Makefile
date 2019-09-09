VERSION=$(shell cat VERSION)

all:	ssh

ssh:	Dockerfile
	docker build --rm --tag knrt10/ssh --label VERSION=$(VERSION) . 

