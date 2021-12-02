#!/usr/bin/env perl

use 5.34.0;
use warnings;

use AOC::Util qw( read_input_file_to_array );

my @directions = read_input_file_to_array("02-directions");

my ($horizontal_pos, $depth, $aim) = (0, 0, 0);

for my $direction (@directions) {
    # "forward 8" => (forward, 8)
    my ($op, $param) = split(/\s+/, $direction);
    my $val = int($param);
    $aim += $val if ($op eq 'down');
    $aim -= $val if ($op eq 'up');
    if ($op eq 'forward') {
        $horizontal_pos += $val;
        $depth += $aim * $val;
    }
}

say "horiz:$horizontal_pos|depth:$depth|aim:$aim";
my $result = $horizontal_pos * $depth;
say "horiz * depth = $result";
