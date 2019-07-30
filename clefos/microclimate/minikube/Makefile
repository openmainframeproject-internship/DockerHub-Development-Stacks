VERSION=$(shell cat VERSION)
THIS=$(shell pwd)

all:	minikube

minikube: Dockerfile 
	@docker build --rm --tag clefos/minikube:latest . 

<<<<<<< HEAD
go/src/k8s.io/minikube/out/minikube-linux-s390x:
	export GOPATH=$(THIS)/go ; \
	git clone https://github.com/kubernetes/minikube.git $(THIS)/go/src/k8s.io/minikube ; \
	cd $(THIS)/go/src/k8s.io/minikube ; \
	git checkout v0.30.0 ; \
	patch -p1 -i $(THIS)/minikube-s390x.patch ; \
	GOPATH=$(THIS)/go make out/minikube-linux-s390x 

=======
>>>>>>> 06e8d74eccde8d538a21db3391a355fa98da8933
push:
	docker tag clefos/minikube:latest clefos/minikube:$(VERSION)
	docker push clefos/minikube:latest
	docker push clefos/minikube:$(VERSION)
	@rm -rf go

clean:
	docker rmi clefos/minikube:latest || true
	docker rmi clefos/minikube:$(VERSION) || true
	@rm -rf go
