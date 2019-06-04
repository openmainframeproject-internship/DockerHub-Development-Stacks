VERSION=$(shell cat VERSION)

all:		redis

redis:		Dockerfile
		docker build --rm --tag vedarth/redis --label VERSION=$(VERSION) .