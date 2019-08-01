VERSION=0.0.1

all:		django

nodejs:		Dockerfile
		docker build --rm --tag vedarth/nodejs:10.15.2 --label VERSION=$(VERSION) .

clean:
		docker rmi vedarth/nodejs:10.15.2