$CONTAINER_NAME = "docker_kali"

$DOCKER_ID = (docker ps -aq --filter name=${CONTAINER_NAME})
if([String]::IsNullOrEmpty(${DOCKER_ID})) {

    echo "The kali is building ..."
    docker-compose up -d

    echo "Waiting for postgres db up ..."
    Sleep 30

    echo "All is up"
}


$DOCKER_ID = (docker ps -aq --filter name=${CONTAINER_NAME})
if(![String]::IsNullOrEmpty(${DOCKER_ID})) {

    echo "Init msf db ..."
    docker exec -u root ${DOCKER_ID} /bin/bash -c "/usr/bin/msfdb init"

    echo "Openning the kali terminal ..."
    docker exec -it -u root ${DOCKER_ID} /bin/bash
}