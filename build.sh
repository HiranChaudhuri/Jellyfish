#!/bin/bash -ex
#
# Configuration section
OXPNAME="${OXPNAME:-JellyFish}"
VERSION="${VERSION:-0.0}"
AUTHOR="${AUTHOR:-cube}"
LICENSE="${LICENSE:-CC BY-SA 4.0}"

#
# No configuration any more
#

pushd .
cd "$(dirname "$0")"
. ./buildsystem/buildscript.sh
popd
