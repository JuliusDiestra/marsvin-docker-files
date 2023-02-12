FROM ubuntu:20.04

ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

# General
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y cmake \
            git \
            build-essential \
            valgrind \
            wget \
            software-properties-common

# clang-format & clang-tidy
RUN wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc
RUN apt-add-repository "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-15 main"
RUN apt-get update
RUN apt-get install -y clang-15 \
                       clang-format-15 \
                       clang-tidy-15
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
