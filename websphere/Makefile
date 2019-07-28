.PHONY: all test clean

test:
	cd test/ && ./buildAll.sh

push:
	cd test/ && ./pushAll.sh

clean:
	docker rmi clefos/websphere-liberty:kernel
	docker rmi clefos/websphere-liberty:microProfile
	docker rmi clefos/websphere-liberty:webProfile6
	docker rmi clefos/websphere-liberty:webProfile7
	docker rmi clefos/websphere-liberty:javaee7
	docker rmi clefos/websphere-liberty:beta