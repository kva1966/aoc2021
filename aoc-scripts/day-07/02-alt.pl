#!/usr/bin/env perl

use 5.34.0;
use warnings;
use Function::Parameters;
use List::Util qw( uniqint );

use AOC::Util qw( read_input_file_to_array );

my @crab_pos_lines = read_input_file_to_array("07-crab-positions");
my @crab_positions = map { $_ } split(",", $crab_pos_lines[0]);
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

fun calculate_fuel_cost($dist) {
    # From Ade: analytic version: triangular number
    # https://byjus.com/maths/triangular-numbers/
    # https://www.mathsisfun.com/algebra/triangular-numbers.html
    return $dist * (1 + $dist) / 2
}
