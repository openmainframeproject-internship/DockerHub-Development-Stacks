VERSION=$(shell cat VERSION)

all:		postgresql

postgresql:		Dockerfile
		docker build --rm --tag vedarth/postgresql --label VERSION=$(VERSION) .