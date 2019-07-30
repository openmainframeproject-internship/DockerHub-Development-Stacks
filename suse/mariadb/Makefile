VERSION=$(shell cat VERSION)

all:		vedarth

mariadb:	Dockerfile
		docker build --rm --tag vedarth/mariadb:10.2.22 --label VERSION=$(VERSION) .
