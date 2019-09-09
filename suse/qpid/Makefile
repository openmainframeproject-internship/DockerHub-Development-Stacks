VERSION=$(shell cat VERSION)

all:		qpid

qpid:		Dockerfile
		docker build --rm --tag knrt10/qpid --label VERSION=$(VERSION) . 
