FROM ubuntu:20.04

ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

# General
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y wget \
            build-essential \
            software-properties-common

# Download Golang package
RUN wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz --directory-prefix=/tmp/
RUN rm -rf /usr/local/go
RUN cd /tmp && tar -C /usr/local -xzf /tmp/go1.21.1.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists

# Create working directory with applications
WORKDIR /tmp/workspace

USER user

