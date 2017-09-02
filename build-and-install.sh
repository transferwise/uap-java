#!/bin/sh

set -e

BASE=$(realpath $(dirname $0))
REPOSITORY="$BASE/repository"

if [ ! -d "$REPOSITORY" ]; then
    echo
    echo "Could not fimd install path '$REPOSITORY'"
    echo
    exit 1
fi

if [ "$1" = "" ]; then
    SOURCE=$(realpath "$BASE/../uap-java")
else
    SOURCE=$(realpath "$1")
fi

if [ ! -d "$SOURCE" -o ! -f "$SOURCE/pom.xml" ]; then
    echo
    echo "Incorrect directory '$SOURCE'"
    echo
    exit 1
fi

echo "Using directory '$SOURCE', installing to '$REPOSITORY'"

(
    cd "$SOURCE"
    mvn -q clean
    mvn -q deploy \
        "-DaltDeploymentRepository=none::default::file:$REPOSITORY"
)
