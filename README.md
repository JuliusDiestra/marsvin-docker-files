# docker-files

Docker files useful to build Marsvin libraries.

The **marsvin_docker** is a CLI app that can be used tobuild a docker image and run a docker container if you are lazy.

While the script run the docker container, it will mount to current location directory in **/tmp/workspace** into the docker container.

The directory in mounted into **/tmp/workspace** is mounted with type=bind, therefore the files are updated in the host and docker automatically.

## How to use **marsvin_docker** cli

### Building docker image

```
./marsvin_docker --dockerfile <path-to-dockerfile>/< docker-file-name > --dockerimage < docker-image-name  >
```

This command will run:
```
sudo docker build . -t <docker-image-name> -f <path-to-dockerfile>/<docker-file-name>
```

### Run docker container

```
./marsvin_docker --dockerimage < docker-image-name  > --dockercontainer < docker-container-name >
```

This command will run:
sudo docker run --name <docker-container-name> -it --mount src="$(pwd)",target=/tmp/workspace,type=bind <docker-image-name>

