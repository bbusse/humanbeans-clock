# syntax=docker/dockerfile:1
#
# Stages
#   flutter-sdk  SDK plus Linux toolchain, also usable as a dev shell
#   build        pub get, analyze, test, build linux and web
#   artifacts    scratch image with just the build output, for --output
#
# Usage: see README.md, Build in a container, or ./build.sh

ARG FLUTTER_VERSION=3.47.2

FROM docker.io/library/ubuntu:24.04 AS flutter-sdk

ENV DEBIAN_FRONTEND=noninteractive

# Flutter tool prerequisites and Linux desktop build toolchain
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl git unzip xz-utils zip \
        clang cmake ninja-build pkg-config \
        libgtk-3-dev liblzma-dev libglu1-mesa libstdc++-12-dev \
    && rm -rf /var/lib/apt/lists/*

ARG FLUTTER_VERSION
ENV FLUTTER_HOME=/opt/flutter \
    PUB_CACHE=/root/.pub-cache \
    PATH=/opt/flutter/bin:/root/.pub-cache/bin:$PATH \
    CI=true

# Clone rather than download the tarball
# tarballs are x64 only, the git checkout works on amd64 and arm64 hosts
RUN git clone --depth 1 -b "${FLUTTER_VERSION}" https://github.com/flutter/flutter.git "${FLUTTER_HOME}" \
    && git config --global --add safe.directory "${FLUTTER_HOME}" \
    && flutter --disable-analytics \
    && flutter precache --linux --web \
    && flutter doctor -v \
    && flutter --version

WORKDIR /app

FROM flutter-sdk AS build

# Resolve dependencies first so the pub cache layer survives source edits
# packages/ holds the vendored flare_flutter path dependency
COPY pubspec.yaml pubspec.lock ./
COPY packages ./packages
RUN flutter pub get

COPY . .

RUN flutter analyze \
    && flutter test \
    && flutter build linux --release \
    && flutter build web --release

FROM scratch AS artifacts

# build/linux/<arch>/release/bundle becomes /linux
COPY --from=build /app/build/linux/*/release/bundle /linux
COPY --from=build /app/build/web /web
