VERSION=$(shell cat VERSION)

all:		postgresql

postgresql:		Dockerfile
		docker build --rm --tag vedarth/postgresql:10.6.8 --label VERSION=$(VERSION) .