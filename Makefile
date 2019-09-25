VERSION=2.1.0-beta
IMAGE=nuls/client-node:${VERSION}
CONTAINER=nuls_${VERSION}
VOLUME=${PWD}

build: 
	docker build -t ${IMAGE} .

delete:
	docker rm ${CONTAINER}

run: build
	docker run --name ${CONTAINER} -d \
		-p 8001:8001 \
		-p 8002:8002 \
		-p 8003:8003 \
		-v ${VOLUME}/data:/nuls/data \
		-v ${VOLUME}/logs:/nuls/Logs \
		${IMAGE} \
	|| docker start ${CONTAINER}

status:
	docker exec -it ${CONTAINER} ./check-status

start: run | status

cmd:
	docker exec -it ${CONTAINER} ./cmd

shell:
	docker exec -it ${CONTAINER} bash

stop:
	docker kill ${CONTAINER}