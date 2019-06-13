VERSION=$(shell cat VERSION)

all:		vedarth

vedarth:	Dockerfile
		docker build --rm --tag vedarth/mariadb:latest --label VERSION=$(VERSION) .
