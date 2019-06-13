VERSION=$(shell cat VERSION)

all:		vedarth

mariadb:	Dockerfile
		docker build --rm --tag vedarth/mariadb:latest --label VERSION=$(VERSION) .
