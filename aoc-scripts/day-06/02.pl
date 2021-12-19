#!/usr/bin/env perl

use 5.34.0;
use warnings;

use AOC::FishTimers;
use AOC::Util qw( read_input_file_to_array );

my @timer_lines = read_input_file_to_array("06-fishtimers");
my @timers = map { $_ } split(",", $timer_lines[0]);

my $simulation_days = 256;

my $timers = AOC::FishTimers->new;

#$timers->push(3, 4, 3, 1, 2);
$timers->push(@timers);
#$timers->dump_counts();

$timers->simulate($simulation_days);

say "Fish count: " . $timers->fish_count;
