#!/usr/bin/env perl

use 5.34.0;
use warnings;

use List::Util qw( sum );
use Function::Parameters qw( :strict );
use AOC::Util qw( read_input_file_to_array );

fun count_adjacent_largers(@arr) {
    my $count = 0;
    my $a = shift @arr;
    for my $b (@arr) {
        # print $a, " ", $b, "\n";
        $count++ if ($b > $a);
        $a = $b;
    }    
    return $count;
}

fun rolling_sum($rolling_count, @arr) {
    my $len = scalar @arr;
    my @rollsums = ();
    my $last_idx = $len - $rolling_count;
    for my $idx (0 .. ($len - 1)) {
        my $window_end_idx = $idx + $rolling_count - 1;
        push @rollsums, sum( @arr[$idx .. $window_end_idx] )
            if $idx <= $last_idx;
    }
    # use Data::Dumper::Concise; say STDERR Dumper(\@rollsums);
    return @rollsums;
}

my @measurements = read_input_file_to_array("1");
#my @measurements = ( 1, 2, 1, 6, 7, 6, 3, 2, 3, 4, 1, 1, 1, 2 );

my $rolling_count = 3;
my $len = scalar @measurements;

my $result;

if ($len <= $rolling_count) {
    $result = 0;
} else {
    $result = count_adjacent_largers(
        rolling_sum($rolling_count, @measurements)
    );
}

say $result;
