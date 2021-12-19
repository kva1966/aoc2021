#!/bin/bash

CMD="docker compose run --rm"

if [ -z $TIME_IT ]; then
    $CMD aoc-perl "$@"
else
    $CMD aoc-perl-time "$@"
fi
