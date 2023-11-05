#!/bin/bash -ex
#
# Configuration section
OXPNAME=JellyFish
VERSION=0.0
AUTHOR=cube
LICENSE="CC-BY-SA 3.0"

#
# No configuration any more
#

pushd .
cd "$(dirname "$0")"
. ./buildsystem/buildscript.sh
popd
