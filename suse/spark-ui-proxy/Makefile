VERSION=$(shell cat VERSION)

all:		spark-ui-proxy

spark-ui-proxy:	Dockerfile
		docker build --rm --tag knrt10/spark-ui-proxy --label VERSION=$(VERSION) . 
