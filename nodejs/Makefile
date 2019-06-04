VERSION=$(shell cat VERSION)

all:		django

nodejs:		Dockerfile
		docker build --rm --tag vedarth/redis --label VERSION=$(VERSION) .