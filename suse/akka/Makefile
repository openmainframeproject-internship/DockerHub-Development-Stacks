VERSION=$(shell cat VERSION)

all:		akka

akka:		Dockerfile
		docker build --rm --tag knrt10/akka --label VERSION=$(VERSION) . 
