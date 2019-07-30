VERSION=$(shell cat VERSION)

all:		nginx

nginx:		Dockerfile
		docker build --rm --tag vedarth/nginx:1.14.2 --label VERSION=$(VERSION) .