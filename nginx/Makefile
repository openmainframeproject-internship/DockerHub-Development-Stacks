VERSION=$(shell cat VERSION)

all:		django

nginx:		Dockerfile
		docker build --rm --tag vedarth/nginx --label VERSION=$(VERSION) .