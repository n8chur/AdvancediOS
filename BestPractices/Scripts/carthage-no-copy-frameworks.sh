#!/bin/bash

# This script is used to disable the carthage copy-frameworks phase when building the project
# in the context of the workspace so that all dependencies are built from project files instead.

parameter="$1"

if [ "$1" == "copy-frameworks" ]; then
    echo "Skipping copy-frameworks."
else
    carthage "$@"
fi

