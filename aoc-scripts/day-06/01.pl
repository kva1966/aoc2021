#!/usr/bin/env perl

use 5.34.0;
use warnings;
use Function::Parameters;
use List::Util qw( head tail );
use Readonly;

use AOC::Util qw( read_input_file_to_array );

Readonly my $UNKNOWN_PREV_TIMER => -1;

my @timer_lines = read_input_file_to_array("06-fishtimers");
# Convert timers into [prev, curr], defaulting prev to -1 if we don't know.
my @timers = map { [$UNKNOWN_PREV_TIMER, $_] } split(",", $timer_lines[0]);
# my @timers = ([-1, 3], [-1, 4], [-1, 3], [-1, 1], [-1, 2]);

my $simulation_days = 80;

for my $day (0..$simulation_days - 1) {
    # show_state($day, \@timers);
    @timers = map { decrement_timer($_) } @timers;
    my $new_fish_count = scalar( grep { spawn_new($_) } @timers );
    push @timers,
        map { [$UNKNOWN_PREV_TIMER, 8] } 1..$new_fish_count;
}

say "lantern fish count: " . scalar @timers;

fun decrement_timer($fish_timer) {
    my ($prev, $curr) = @{$fish_timer};
    $prev = $curr;
    $curr = $curr == 0 ? 6 : $curr - 1;
    return [$prev, $curr];
}

fun spawn_new($fish_timer) {
    my ($prev, $curr) = @{$fish_timer};
    # transition to new counter.
    return $prev == 0 && $curr == 6;
}

fun show_state($day, $timers) {
    my @currs = map { $_->[1] } @{$timers};
    printf("Day %02d: %s\n", $day, join(",", @currs));
}
