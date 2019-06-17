VERSION=$(shell cat VERSION)

all:		vedarth

mariadb:	Dockerfile
		docker build --rm --tag vedarth/mariadb:2.0.8 --label VERSION=$(VERSION) .
