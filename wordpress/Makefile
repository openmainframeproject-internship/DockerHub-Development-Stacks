VERSION=$(shell cat VERSION)

all:		wordpress

wordpress:		Dockerfile
		docker build --rm --tag vedarth/wordpress --label VERSION=$(VERSION) .