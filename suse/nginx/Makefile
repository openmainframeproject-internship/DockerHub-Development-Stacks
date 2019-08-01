VERSION=0.0.1

all:		nginx

nginx:		Dockerfile
		docker build --rm --tag vedarth/nginx:1.14.2 --label VERSION=$(VERSION) .

clean:
		docker rmi vedarth/nginx:1.14.2