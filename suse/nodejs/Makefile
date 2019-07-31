VERSION=$(shell cat VERSION)

all:		django

nodejs:		Dockerfile
		docker build --rm --tag vedarth/nodejs:10.15.2 --label VERSION=$(VERSION) .

clean:
		docker rmi vedarth/nodejs:10.15.2