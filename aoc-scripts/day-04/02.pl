#!/usr/bin/env perl

use 5.34.0;
use warnings;

use AOC::BingoBoards;
use AOC::Util qw( read_input_file_to_array );

my @bingo_data = read_input_file_to_array("04-bingo");

my @nums_to_draw = split(/,/, $bingo_data[0]);

my $bingo_boards = AOC::BingoBoards->new(
    bingo_data => \@bingo_data,
    start_idx => 2
);

my ($idx, $board, $last_num) = 
    @{AOC::BingoBoards::last_won(\@nums_to_draw, $bingo_boards)};

say "board_idx: $idx, last_num: " . $last_num . ", score: " . $board->calculate_score($last_num);
