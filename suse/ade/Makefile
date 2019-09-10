VERSION=$(shell cat VERSION)

all:	ade

ade:	Dockerfile
	docker build --rm --tag knrt10/ade --label VERSION=$(VERSION) . 
