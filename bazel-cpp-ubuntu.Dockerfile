FROM ubuntu:20.04

ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

# General
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y build-essential \
                       cmake \
                       git \
                       curl \
                       apt-transport-https \
                       curl \
                       gnupg

# Bazel
RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
RUN mv bazel-archive-keyring.gpg /usr/share/keyrings
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y bazel

# Google Test
RUN git clone -q https://github.com/google/googletest.git /googletest \
  && mkdir -p /googletest/build \
  && cd /googletest/build \
  && cmake .. && make && make install \
  && cd / && rm -rf /googletest

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists

# Create working directory with applications
WORKDIR /tmp/workspace

USER user
