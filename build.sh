#!/usr/bin/env sh
# Build the Linux and web targets inside a container and copy the results to ./dist
#
#   ./build.sh            # uses podman if available, docker otherwise
#   ENGINE=docker ./build.sh
#
# Everything (Flutter SDK, pub packages, toolchain) lives in the image
# the host only needs podman or docker
set -eu

cd "$(dirname "$0")"

ENGINE="${ENGINE:-$(command -v podman >/dev/null 2>&1 && echo podman || echo docker)}"
IMAGE="${IMAGE:-humanbeans-clock}"
DIST="${DIST:-dist}"

echo ">> building with $ENGINE"
"$ENGINE" build -f Containerfile --target build -t "$IMAGE:build" .

echo ">> extracting artifacts to $DIST/"
rm -rf "$DIST"
mkdir -p "$DIST"
cid="$("$ENGINE" create "$IMAGE:build")"
trap '"$ENGINE" rm -f "$cid" >/dev/null' EXIT
"$ENGINE" cp "$cid:/app/build/web" "$DIST/web"
# build/linux/<arch>/release/bundle
"$ENGINE" cp "$cid:/app/build/linux" "$DIST/linux-tmp"
mv "$DIST"/linux-tmp/*/release/bundle "$DIST/linux"
rm -rf "$DIST/linux-tmp"

echo ">> done"
echo "   Linux app : $DIST/linux/humanbeans_clock"
echo "   Web app   : $DIST/web/index.html"
