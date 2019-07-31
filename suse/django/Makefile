VERSION=$(shell cat VERSION)

all:		django

django:		Dockerfile
		docker build --rm --tag vedarth/django:2.0.8 --label VERSION=$(VERSION) .

clean:
		docker rmi vedarth/django:2.0.8