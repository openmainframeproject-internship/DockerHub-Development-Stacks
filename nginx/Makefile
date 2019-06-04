VERSION=$(shell cat VERSION)

all:		nginx

nginx:		Dockerfile
		docker build --rm --tag vedarth/nginx --label VERSION=$(VERSION) .