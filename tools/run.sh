#!/bin/bash

docker run \
    --rm \
    -it \
    -v $PWD/:/app/data \
    -e PERL5OPT="-MCarp=verbose" \
    -e PERL5LIB='/app/data/lib' \
    aoc-perl:master \
    "$@"
