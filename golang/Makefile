VERSION=$(shell cat VERSION)

all:		golang

golang:		Dockerfile
		docker build --rm --tag vedarth/golang --label VERSION=$(VERSION) . 