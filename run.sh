#!/bin/sh

DOCKER_ID=`docker ps -aq --filter name=docker_kali`
if [ -z "${DOCKER_ID}" ]; then

    echo "The kali is building ..."
    docker-compose up -d

    echo "Waiting for postgres db up ..."
    sleep 30

    echo "All is up"
fi


if [ ! -z "${DOCKER_ID}" ]; then

    echo "Init msf db ..."
    docker exec ${DOCKER_ID} /bin/bash -c "/usr/bin/msfdb init"

    echo "Openning the kali terminal ..."
    docker exec -it ${DOCKER_ID} /bin/bash
fi