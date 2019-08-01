VERSION=0.0.1

all:		wordpress

wordpress:		Dockerfile
		docker build --rm --tag vedarth/wordpress:5.2.1 --label VERSION=$(VERSION) .

clean:
		docker rmi vedarth/wordpress:5.2.1