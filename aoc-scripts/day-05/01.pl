#!/usr/bin/env perl

use 5.34.0;
use warnings;
use Readonly;

use AOC::Line;
use AOC::Util qw( read_input_file_to_array );

my @line_specs = read_input_file_to_array("05-lines");

# horizontal: where y1 = y2
# vertical: where x1 = x2

my @lines = map { AOC::Line::new_line($_) } @line_specs;
my %all_points;

for my $line (@lines) {
    next unless ($line->is_vertical || $line->is_horizontal);
    my @points = $line->enumerate_points();
    for my $point (@points) {
        my $pstr = $point->to_string;
        $all_points{$pstr} = 0 if !exists $all_points{$pstr};
        $all_points{$pstr} += 1;
    }
}

my $points_count = scalar( grep { $_ >= 2 } values(%all_points) );
say "point count: " . $points_count;
