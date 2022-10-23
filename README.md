# docker-files

Docker files useful to build Marsvin libraries or something else.

The **marsvin_docker** is a CLI app that can be used to build a docker image and run a docker container if you are lazy.

While the script run the docker container, it will mount to current location directory in **/tmp/workspace** into the docker container.

The directory in mounted into **/tmp/workspace** is mounted with type=bind, therefore the files are updated in the host and docker automatically.

## How to use **marsvin_docker** CLI

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
```
sudo docker run --name <docker-container-name> --rm -it --mount src="$(pwd)",target=/tmp/workspace,type=bind <docker-image-name>
```
where **$(pwd)** is the current directory where the **marsvin_docker** script is called.


### Example:

For example you want to build a C++ project using **cpp-ubuntu.Dockerfile** file.

Two paths:

**/path/to/cpp-source-code :** Path where C++ source code project is located.
**/path/to/cloned-repo:** Path where this repository is cloned.

1. Clone repository

```
cd /path/to/cloned-repo
git clone git@github.com:MarsvinTech/docker-files.git
```

2. Build docker image

```
# Go to source code directory
cd/path/to/cpp-source-code
# Build image called my-docker-image-name
/path/to/cloned-repo/docker-files/marsvin_docker --dockerfile cpp-ubuntu.Dockerfile --dockerimage my-docker-image-name
```

3. Run container

```
# Run container called my-docker-container-name
/path/to/cloned-repo/docker-files/marsvin_docker --dockerimage my-docker-image-name --dockercontainer my-docker-container-name
```

