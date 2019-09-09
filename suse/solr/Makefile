VERSION=$(shell cat VERSION)

all:		solr

solr:		Dockerfile
		docker build --rm --tag knrt10/solr --label VERSION=$(VERSION) . 
