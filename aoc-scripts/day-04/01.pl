#!/usr/bin/env perl

use 5.34.0;
use warnings;
use Readonly;

use AOC::BingoBoards;
use AOC::Util qw( read_input_file_to_array );

Readonly my $grid_size => $AOC::BingoBoard::GRID_SIZE;

my @bingo_data = read_input_file_to_array("04-bingo");

my @nums_to_draw = split(/,/, $bingo_data[0]);

my $bingo_boards = AOC::BingoBoards->new(
    bingo_data => \@bingo_data,
    start_idx => 2
);

my $count = 0;

for my $num (@nums_to_draw) {    
    $bingo_boards->mark($num);

    # don't bother checking until we have at least the length of a row or col
    if ($count < $grid_size) {
        $count += 1;
        next;
    }
    
    my $board_info = $bingo_boards->has_won();
    if ($board_info) {
        my $winning_board_number = $board_info->[0] + 1;
        my $winning_board_score = $board_info->[1]->calculate_score($num);
        say "Winning Board Number: $winning_board_number|Score: $winning_board_score";
        last;
    }
}
