#!/usr/bin/env perl

use 5.34.0;
use warnings;
use Readonly;

use AOC::Line;
use AOC::Util qw( read_input_file_to_array );

my @line_specs = read_input_file_to_array("05-lines");
# my @line_specs = ('69,818 -> 73,818', '84,818 -> 84,810', '960,900 -> 965,905');

my @lines = map { AOC::Line::new_line($_) } @line_specs;
my %all_points;

for my $line (@lines) {
    my $point_iter = $line->enumerate_points();
    while (my $point = $point_iter->()) {
        $all_points{$point->to_string} += 1;
    }
}

my $points_count = scalar( grep { $_ >= 2 } values(%all_points) );
say "point count: " . $points_count;
