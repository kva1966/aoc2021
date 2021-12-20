#!/usr/bin/env perl

use 5.34.0;
use warnings;
use Function::Parameters;
use List::Util qw( uniqint );
#use Memoize qw( memoize );

use AOC::Util qw( read_input_file_to_array );

# our custom implementation is faster by a factor of 2.
#memoize('calculate_fuel_cost');

my @crab_pos_lines = read_input_file_to_array("07-crab-positions");
my @crab_positions = split(",", $crab_pos_lines[0]);
#my @crab_positions = (16, 1, 2, 0, 4, 2, 7, 1, 2, 14);

my ($best_position, $fuel_used) = least_fuel_position();

say "Best Pos $best_position with Fuel $fuel_used";

#say calculate_fuel_cost(2);

fun least_fuel_position() {
    my %fuel_pos;

    for my $ref_pos (uniqint @crab_positions) {        
        for my $pos (@crab_positions) {
            $fuel_pos{$ref_pos} += calculate_fuel_cost(abs($pos - $ref_pos));
        }
    }

    my @keys = sort { $fuel_pos{$a} <=> $fuel_pos{$b} } keys %fuel_pos;

    #use Data::Dumper::Concise; say STDERR Dumper(\%fuel_pos);
    my $best_pos = $keys[0];
    return ($best_pos, $fuel_pos{$best_pos});
}

my %fuel_cost_memo;

fun calculate_fuel_cost($dist) {
    return 0 if $dist == 0;
    return $fuel_cost_memo{$dist} if exists $fuel_cost_memo{$dist};

    # additional optimisation, if we have a prior distance, we can
    # determine the current distance's cost.
    if (exists $fuel_cost_memo{$dist - 1}) {
        my $new_cost = $fuel_cost_memo{$dist - 1} + $dist;
        memoise($dist, $new_cost);
        return $new_cost;
    }

    my $total = 0;
    my $prev_cost = 1;

    for my $i (1 .. $dist) {
        $total += $prev_cost;
        $prev_cost++;
    }

    memoise($dist, $total);

    return $total;
}

fun memoise($dist, $cost) {
    $fuel_cost_memo{$dist} = $cost;
}