package AOC::BingoBoard;

use 5.34.0;
use warnings;

use Data::Dumper::Concise qw( Dumper );
use Function::Parameters qw( :strict );
use List::Util qw( all any sum );
use Moo;
use Readonly;
use String::Util qw( trim );

use AOC::Util qw( assert );

Readonly our $GRID_SIZE => 5; # => 5 x 5, assume a square grid.

# GRID_SIZE lines, each a row in the board with GRID_SIZE ints.
# Array ref of strings, e.g. for GRID_SIZE 5
# [
#    "1  2   9   4   5",
#    "3  1  10  14  35",
#    "6  4  20  11   3",
#    "9  5   2   1   8",
#    "3  6  10  14  35",
# ]
has board_lines => (
    is => 'ro'
);

###
# 2D array, of hash refs { num: bool }, e.g. { 33: 0 }. The bool indicates
# whether the number has been called or not.
#
# [
#  ...
#  [ [{num: bool} ... [{num: bool}],
#  [ [{num: bool} ... [{num: bool}],
#  [ [{num: bool} ... [{num: bool}],
#  ...
# ]
###
has _board_data => (
    is => 'lazy'
);

method _build__board_data() {
    my @lines = @{$self->board_lines};
    #say "linez:\n" . Dumper(\@lines);
    assert(scalar @lines == $GRID_SIZE, "Expecting to have $GRID_SIZE board lines");
    my $board = [];

    for my $line (@lines) {
        # say "processing $line";
        # say "row => " . Dumper(\split(/\s+/, $line));
        # hashref of num => boolean, where boolean int signifies picked or not picked.
        # single-keyed hashref.
        my @row = map { +{ int($_) => 0 } } split(/\s+/, trim($line));
        assert(scalar @row == $GRID_SIZE, "Expecting to have $GRID_SIZE numbers per row");
        push @{$board}, \@row;
    }

    return $board;
}


method dump_data() {
    say Dumper($self->_board_data);
}

method mark($num) {
    $self->_foreach(fun($hash_ref) {
        $hash_ref->{$num} = 1 if (exists $hash_ref->{$num});
    });
}

method get_unmarked() {
    return $self->_grep(fun($hash_ref) {
        return _to_key_val($hash_ref)->[1] == 0;
    });
}

method has_won() {
    my @indexes = (0 .. $GRID_SIZE - 1);
    return 1 if any { $self->_row_completed($_) } @indexes;
    return 1 if any { $self->_col_completed($_) } @indexes;
    return 0;
}

method calculate_score($last_called_num) {
    my @keys = map { _to_key_val($_)->[0] } $self->get_unmarked();
    return sum(@keys) * $last_called_num;
}

method _row_completed($row_idx) {
    my $row = $self->_board_data->[$row_idx];
    return _all_marked($row);
}

method _col_completed($col_idx) {
    my @column;

    # collect column at index hash refs.
    for my $row (@{$self->_board_data}) {
        push @column, $row->[$col_idx];
    }

    return _all_marked(\@column);
}

fun _all_marked($row_or_col_arr) {
    return all { _to_key_val($_)->[1] == 1 } @{$row_or_col_arr};
}

fun _to_key_val($hash_ref) {
    my ($key, $val) = %{$hash_ref};
    return [$key, $val];
}

method _grep($predicate_fn) {
    my @results;
    my $grep_closure = fun($hash_ref) {
        push @results, $hash_ref if $predicate_fn->($hash_ref);
    };
    $self->_foreach($grep_closure);
    return @results;
}

method _map($fn) {    
    my @results;
    my $add_closure = fun($hash_ref) {
        push @results, $fn->($hash_ref);
    };
    $self->_foreach($add_closure);
    return @results;
}

method _foreach($fn) {
    for my $row (@{$self->_board_data}) {
        for my $hash_ref (@{$row}) {
            $fn->($hash_ref);
        }
    }
}


1;
