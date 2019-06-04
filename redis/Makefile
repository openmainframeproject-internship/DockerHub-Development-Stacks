VERSION=$(shell cat VERSION)

all:		django

django:		Dockerfile
		docker build --rm --tag vedarth/redis --label VERSION=$(VERSION) .