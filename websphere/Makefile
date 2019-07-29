VERSION=$(shell cat VERSION)
TAG=$(shell cat VERSION | awk -F \- '{print $$1}')
THIS=$(PWD)

all:	websphere

websphere: 
	@git clone https://github.com/WASdev/ci.docker.git 
	cd ci.docker && patch -p 1 -i ../websphere-clefos-s390x.patch
	cd ci.docker && make

push:
<<<<<<< HEAD
	cd test/ && ./pushAll.sh

clean:
	docker rmi clefos/websphere-liberty:kernel
	docker rmi clefos/websphere-liberty:microProfile
	docker rmi clefos/websphere-liberty:webProfile6
	docker rmi clefos/websphere-liberty:webProfile7
	docker rmi clefos/websphere-liberty:javaee7
	docker rmi clefos/websphere-liberty:beta
=======
	cd ci.docker/test && ./pushAll.sh docker.io webProfile8
	@rm -rf ci.docker

clean:
	@./clean.sh || true
	@rm -rf ci.docker
>>>>>>> 06e8d74eccde8d538a21db3391a355fa98da8933
