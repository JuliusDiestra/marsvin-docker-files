#!/bin/bash
docker_file_name='cpp-ubuntu.Dockerfile'
flag_docker=$(git diff --name-only origin/main HEAD | grep $docker_file_name)
if [[ "$docker_file_name" == "$flag_docker" ]]; then
    docker_file_changed=true;
else
    docker_file_changed=false;
fi

echo "Docker file $docker_file_name is changed : $docker_file_changed"

echo "DOCKER_FILE_CHANGED=$docker_file_changed" >> $GITHUB_OUTPUT
