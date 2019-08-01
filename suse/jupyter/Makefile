VERSION=0.0.1

all:		jupyter

jupyter:		Dockerfile
		docker build --rm --tag vedarth/jupyter:5.7.8 --label VERSION=$(VERSION) .

clean:
		docker rmi vedarth/jupyter:5.7.8