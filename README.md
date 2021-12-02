# aoc2021

Advent of Code 2021, using Perl 5.34.

# Build

Dockerised Perl:

```
docker compose build
```

# Run

```
# Bootstraps (via docker-compose.yml) the module path ./lib 
# and mounts '.' as /app/data
./tools/run.sh aoc-scripts/day-01/01.pl
```
