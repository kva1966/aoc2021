package AOC::FishTimers;

use 5.34.0;
use warnings;

use Data::Dumper::Concise qw( Dumper );
use Function::Parameters qw( :strict );
use List::Util qw( sum );
use Moo;


###
# hashref of: timer -> count
###
has _timers => (
    is => 'ro',
    default => method() { +{} }
);

method push(@timers) {
    for my $timer (@timers) {
        $self->_timers->{$timer} += 1;
    }
}

method simulate($days) {
    # $self->dump_counts();
    for my $day (1..$days) {
        #say "Day: $day";
        $self->next_iteration();
        #say "-- final at iteration --";
        #$self->dump_counts();
        #say "==";
    }
}

method next_iteration() {
    my @keys = sort { $b <=> $a } keys %{$self->_timers};
    my %additions;

    for my $timer (@keys) {
        my $count = $self->_timers->{$timer};
        # all timers of this value cleared in this iteration.
        $self->_timers->{$timer} = 0;

        if ($timer == 0) {
            $self->_timers->{6} += $count;
            $self->_timers->{8} += $count;
        } else {
            $additions{$timer - 1} = $count;
        }
    }

    for my $timer (keys %additions) {
        $self->_timers->{$timer} += $additions{$timer};
    }
}

method fish_count() {
    return sum(values %{$self->_timers});
}

method dump_counts() {
    my @keys = grep { $self->_timers->{$_} > 0 } keys %{$self->_timers};
    my %hash = map { $_ => $self->_timers->{$_} } @keys;
    say Dumper(\%hash);
    # say Dumper($self->_timers);
}

1;
