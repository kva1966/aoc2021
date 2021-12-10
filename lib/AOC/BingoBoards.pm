package AOC::BingoBoards;

use 5.34.0;
use warnings;

use Function::Parameters qw( :strict );
use Moo;

use AOC::BingoBoard;

has bingo_data => (
    is => 'ro'
);

has start_idx => (
    is => 'ro'
);

has _boards => (
    is => 'lazy'
);

method _build__boards() {
    my @bingo_data = @{$self->bingo_data};
    my $last_line_idx = (scalar @bingo_data) - 1;
    my $start_idx = $self->start_idx;
    my $bingo_lines = $AOC::BingoBoard::GRID_SIZE;
    my @bingo_boards;

    while ($start_idx <= $last_line_idx) {
        my $end_idx = ($start_idx + $bingo_lines - 1);
        # say "start:$start_idx, end:$end_idx";
        my @lines = @bingo_data[$start_idx .. $end_idx];
        my $board = AOC::BingoBoard->new(board_lines => \@lines);
        push @bingo_boards, $board;
        # $board->dump_data();
        $start_idx = $end_idx + 2; # skip empty line
    }

    return \@bingo_boards;
}

method mark($called_num) {
    for my $board (@{$self->_boards}) {
        $board->mark($called_num);
    }
}

method has_won() {
    for my $idx (0 .. $self->count - 1) {
        my $board = $self->get($idx);
        return [$idx, $board] if $board->has_won();
    }
}

method get($idx) {
    return $self->_boards->[$idx];
}

method count() {
    return scalar @{$self->_boards};
}

1;
