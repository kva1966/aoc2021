#!/usr/bin/env perl

use 5.34.0;
use warnings;

use AOC::Util qw( read_input_file_to_array );

my @directions = read_input_file_to_array("02-directions");

my ($horizontal_pos, $depth) = (0, 0);

for my $direction (@directions) {
    # "forward 8" => (forward, 8)
    my ($op, $param) = split(/\s+/, $direction);
    $horizontal_pos += int($param) if ($op eq 'forward');
    $depth += int($param) if ($op eq 'down');
    $depth -= int($param) if ($op eq 'up');
}

say $horizontal_pos, " ", $depth;
my $result = $horizontal_pos * $depth;

say $result;
