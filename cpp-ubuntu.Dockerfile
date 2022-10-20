FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y cmake \
            git \
            build-essential \
            clang-10 \
            clang-format-10 \
            valgrind \
            wget \
            && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

RUN git clone -q https://github.com/google/googletest.git /googletest \
  && mkdir -p /googletest/build \
  && cd /googletest/build \
  && cmake .. && make && make install \
  && cd / && rm -rf /googletest

# Create working directory with applications
WORKDIR /tmp/workspace

