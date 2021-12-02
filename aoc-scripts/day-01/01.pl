#!/usr/bin/env perl

use 5.34.0;
use warnings;

use AOC::Util qw( read_input_file_to_array );

my @measurements = read_input_file_to_array("01-measurements");
#my @measurements = ( 1, 2, 1, 6, 7, 6, 3, 2, 3, 4, 1, 1, 1, 2 );

my $result;

if (scalar @measurements <= 1) {
    $result = 0;
} else {
    my $count = 0;
    my $a = shift @measurements;
    for my $b (@measurements) {
        # print $a, " ", $b, "\n";
        $count++ if ($b > $a);
        $a = $b;
    }
    $result = $count;
}

say $result;
