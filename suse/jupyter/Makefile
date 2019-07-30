VERSION=$(shell cat VERSION)

all:		jupyter

jupyter:		Dockerfile
		docker build --rm --tag vedarth/jupyter:5.7.8 --label VERSION=$(VERSION) . 