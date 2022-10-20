# docker-files
Docker files useful to build Marsvin libraries.

Dockerfile -> Image

sudo docker build . -t <docker-image-name> -f <path-to-dockerfile>/<docker-file-name>

Image -> Container mounting current directory

sudo docker run --name <docker-container-name> -it --mount src="$(pwd)",target=/tmp/workspace,type=bind <docker-image-name>
