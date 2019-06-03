VERSION=$(shell cat VERSION)

all:		django

django:		Dockerfile
		docker build --rm --tag clefos/django --label VERSION=$(VERSION) .