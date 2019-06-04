VERSION=$(shell cat VERSION)

all:		django

nodejs:		Dockerfile
		docker build --rm --tag vedarth/nodejs --label VERSION=$(VERSION) .