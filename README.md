# Docker files for development

Docker files useful to build Marsvin projects or something else.

The **marsvin_docker** is a CLI app that can be used to build a docker image and run a docker container if you are lazy.

Some features:

* While the script run the docker container, the current directory will be mounted in **/tmp/workspace** inside the docker container.

* The host directory is mounted into **/tmp/workspace** and it is mounted with **type=bind**, therefore the files are updated in the host and docker container automatically.

* The script will create a non root user in the Dockerfile. Then the files created inside the docker container are not created as root.

* The script will run the container in interactive mode.

* While you exit the container, the container is stopped and removed. Changes inside the docker container are not saved.

## How to use **marsvin_docker** CLI

### Building docker image

```
./marsvin_docker build --docker-file <path-to-dockerfile>/< docker-file-name > --docker-image < docker-image-name  >
```

Check the docker images by,

```
sudo docker image ls
```

### Run docker container

1. First go to the location where you want to build your project.

```
cd /path/to/myproject
```
2. Run container

The host current directory will be moved into the docker container directory **/tmp/workspace/**. Host and container directories will be synched.

```
./marsvin_docker run --docker-image < docker-image-name  > --docker-container < docker-container-name >
```

### Example:

For example you want to build a C++ project using **cpp-ubuntu.Dockerfile** file.

Two paths:

**/path/to/cpp-project :** Path where C++ source code project is located.

**/path/to/my-repos:** Path where this repository is cloned.

1. Clone repository

```bash
cd /path/to/my-repos
git clone git@github.com:JuliusDiestra/marsvin-docker-files.git
```

2. Build docker image

```bash
# Go marsvin-docker-files cloned repository.
cd /path/to/my-repos/marsvin-docker-files
# Build image called my-docker-image-name
./marsvin_docker build --docker-file cpp-ubuntu.Dockerfile --docker-image my-docker-image-name
```

3. Run container

```bash
# Go to C++ project directory.
cd /path/to/cpp-project
# Run container called my-docker-container-name
/path/to/my-repos/marsvin-docker-files/marsvin_docker run --docker-image my-docker-image-name --docker-container my-docker-container-name
```

