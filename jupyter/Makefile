VERSION=$(shell cat VERSION)

all:		jupyter

jupyter:		Dockerfile
		docker build --rm --tag vedarth/jupyter --label VERSION=$(VERSION) . 