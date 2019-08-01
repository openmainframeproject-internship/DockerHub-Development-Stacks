VERSION=0.0.1

all:		vedarth

mariadb:	Dockerfile
		docker build --rm --tag vedarth/mariadb:10.2.22 --label VERSION=$(VERSION) .

clean:
		docker rmi vedarth/mariadb:10.2.22