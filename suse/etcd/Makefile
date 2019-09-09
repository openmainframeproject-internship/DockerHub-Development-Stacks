VERSION=$(shell cat VERSION)

all:	etcd

etcd:	Dockerfile
	docker build --rm --tag knrt10/etcd --label VERSION=v$(VERSION) . 
