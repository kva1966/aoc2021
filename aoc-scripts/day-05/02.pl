#!/usr/bin/env perl

use 5.34.0;
use warnings;
use Readonly;

use AOC::Line;
use AOC::Util qw( read_input_file_to_array );

my @line_specs = read_input_file_to_array("05-lines");

my @lines = map { AOC::Line::new_line($_) } @line_specs;
my %all_points;

for my $line (@lines) {
    for my $point ($line->enumerate_points()) {
        $all_points{$point->to_string} += 1;
    }
}

my $points_count = scalar( grep { $_ >= 2 } values(%all_points) );
say "point count: " . $points_count;
