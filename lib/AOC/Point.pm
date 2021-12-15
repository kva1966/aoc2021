package AOC::Point;

use 5.34.0;
use warnings;

use Function::Parameters qw( :strict );
use Moo;

has [qw( x y )] => (
    is => 'ro'
);

has _str_rep => (
    is => 'lazy',
);

fun new_point($x, $y) {
    my $point = AOC::Point->new(
        x => $x,
        y => $y
    );
    $point->to_string; # force build
    return $point;
}

method _build__str_rep() {
    return $self->x . "," . $self->y;
}

method to_string() {
    return $self->_str_rep;
}


1;
