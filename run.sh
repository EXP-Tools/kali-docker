#!/bin/sh

CONTAINER_NAME="docker_kali"

DOCKER_ID=`docker ps -aq --filter name=${CONTAINER_NAME}`
if [ -z "${DOCKER_ID}" ]; then

    echo "The kali is building ..."
    docker-compose up -d

    echo "Waiting for postgres db up ..."
    sleep 30

    echo "All is up"
fi

DOCKER_ID=`docker ps -aq --filter name=${CONTAINER_NAME}`
if [ ! -z "${DOCKER_ID}" ]; then

    echo "Init msf db ..."
    docker exec -u root ${DOCKER_ID} /bin/bash -c "/usr/bin/msfdb init"

    echo "Openning the kali terminal ..."
    docker exec -it -u root ${DOCKER_ID} /bin/bash
fi