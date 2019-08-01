VERSION=0.0.1

all:		postgresql

postgresql:		Dockerfile
		docker build --rm --tag vedarth/postgresql:10.6.8 --label VERSION=$(VERSION) .

clean:
		docker rmi vedarth/postgresql:10.6.8