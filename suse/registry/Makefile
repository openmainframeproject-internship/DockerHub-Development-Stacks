VERSION=$(shell cat VERSION)

all:		registry

registry:	Dockerfile
		docker build --rm --tag knrt10/registry --label VERSION=$(VERSION) . 
