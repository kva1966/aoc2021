package AOC::Line;

use 5.34.0;
use warnings;

use Data::Dumper::Concise qw( Dumper );
use Function::Parameters qw( :strict );
use List::Util qw( min max );
use Moo;
use String::Util qw( trim );

use AOC::Point;
use AOC::Util qw( assert );

has [qw( x1 x2 y1 y2 )] => (
    is => 'ro'
);

has _str_rep => (
    is => 'lazy',
);

fun new_line($spec_str) {
    my ($p1, $p2) = split(/ -> /, $spec_str);
    my ($x1, $y1) = split(',', trim($p1));
    my ($x2, $y2) = split(',', trim($p2));

    my $line = AOC::Line->new(
        x1 => int($x1),
        y1 => int($y1),
        x2 => int($x2),
        y2 => int($y2),
    );
    $line->to_string; # force build
    return $line;
}

method _build__str_rep() {    
    return 
        $self->x1 . "," . $self->y1 . ":" . $self->x2 . "," . $self->y2;
}

method dump_line() {
    say Dumper([[$self->x1, $self->y1], [$self->x2, $self->y2]]);
}

method is_vertical() {
    return $self->x1 == $self->x2;
}

method is_horizontal() {
    return $self->y1 == $self->y2;
}

method enumerate_points() {
    my ($x1, $y1) = ($self->x1, $self->y1);
    my ($x2, $y2) = ($self->x2, $self->y2);

    if ($self->is_vertical) {
        my @range = $y1 <= $y2 ? $y1..$y2 : $y2..$y1;
        return map { AOC::Point::new_point($x1, $_) } @range;
    } elsif ($self->is_horizontal) { #  y1 == y2
        my @range = $x1 <= $x2 ? $x1..$x2 : $x2..$x1;
        return map { AOC::Point::new_point($_, $y1) } @range;
    } else {
        # diagonal
        my $xdist = abs($x1 - $x2);
        assert($xdist == abs($y1 - $y2), "Expected to have the same distance between x and y");
        my $xinc = $x1 < $x2 ? 1 : -1;
        my $yinc = $y1 < $y2 ? 1 : -1;
        # init with first point, to include.
        my ($_x, $_y) = ($x1, $y1);

        # Actually takes about twice the time!
        # my @points = ( 
        #     AOC::Point::new_point($x1, $y1), 
        #     map { AOC::Point::new_point($_x += $xinc, $_y += $yinc) } (1..$xdist)
        # );

        my @points;
        push @points,
            AOC::Point::new_point($x1, $y1), # first point to include
            map { AOC::Point::new_point($_x += $xinc, $_y += $yinc) } (1..$xdist);
            
        return @points;
    }
}

method to_string() {
    return $self->_str_rep; 
}


1;
