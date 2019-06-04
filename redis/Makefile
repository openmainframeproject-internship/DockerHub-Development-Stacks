VERSION=$(shell cat VERSION)

all:		django

redis:		Dockerfile
		docker build --rm --tag vedarth/redis --label VERSION=$(VERSION) .