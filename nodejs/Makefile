VERSION=$(shell cat VERSION)

all:		django

nodejs:		Dockerfile
		docker build --rm --tag vedarth/nodejs:10.0 --label VERSION=$(VERSION) .