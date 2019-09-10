VERSION=$(shell cat VERSION)

all:	cobol

cobol:	Dockerfile
	docker build --rm --tag knrt10/cobol --label VERSION=$(VERSION) . 
