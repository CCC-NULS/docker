VERSION=2.0.0-beta3.2
IMAGE=nuls/client-node:${VERSION}
CONTAINER=nuls_${VERSION}
VOLUME=${PWD}

build: 
	docker build -t ${IMAGE} .

delete:
	docker rm ${CONTAINER}

run: build
	docker run --name ${CONTAINER} -d \
		-p 18001:18001 \
		-p 18002:18002 \
		-p 18003:18003 \
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