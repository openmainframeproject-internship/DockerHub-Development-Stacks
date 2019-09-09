VERSION=$(shell cat VERSION)

all:		saltmaster

saltmaster:	Dockerfile
		docker build --rm --tag knrt10/saltmaster --label VERSION=$(VERSION) . 

