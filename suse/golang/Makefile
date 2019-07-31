VERSION=$(shell cat VERSION)

all:		golang

golang:		Dockerfile
		docker build --rm --tag vedarth/golang:1.10.7 --label VERSION=$(VERSION) .

clean:
		docker rmi vedarth/golang:1.10.7