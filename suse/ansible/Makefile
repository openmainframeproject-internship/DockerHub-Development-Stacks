VERSION=$(shell cat VERSION)

all:		ansible

ansible:	Dockerfile
		docker build --rm --tag knrt10/ansible --label VERSION=$(VERSION) . 
