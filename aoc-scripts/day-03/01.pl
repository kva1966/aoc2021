#!/usr/bin/env perl

use 5.34.0;
use warnings;
use Function::Parameters;

use AOC::Util qw( read_input_file_to_array assert );

my @diagnostics_strs = read_input_file_to_array("03-diagnostics");
# my @diagnostics_strs = qw(
#     111110110011
#     101101101000
#     011001111010
# );

my @diagnostics = map { oct("0b$_") } @diagnostics_strs;

fun bit_at($val, $pos) {
    # pos is 0 based.
    my $res = $val & (1 << $pos);
    return $res > 0 ? 1 : 0;
}

fun bits_freq($arr) {
    my $hash = {};
    for my $val (@{$arr}) {
        if (exists $hash->{$val}) {
            $hash->{$val} += 1 
        } else {
            $hash->{$val} = 0;
        }
    }
    return $hash;
}

fun get_max_freq_bit($bits_freq_hash) {
    my $zero_freq = $bits_freq_hash->{0} // 0;
    my $one_freq = $bits_freq_hash->{1} // 0;
    assert $zero_freq != $one_freq, "Not expecting to have equal bit frequencies";
    return $one_freq > $zero_freq ? 1 : 0;
}

fun get_gamma_rate(:$nums_arr, :$bits = 12) {
    # 2D array, each row representing a list bits at that bit position.
    my $res = [];

    for my $num (@{$nums_arr}) {
        for my $pos (0 .. ($bits - 1)) {
            push @{$res->[$pos]}, bit_at($num, $pos);
        }
    }

    my @bits;

    for my $pos_bits (@{$res}) {
        push @bits,
            get_max_freq_bit(bits_freq($pos_bits))
    }

    return oct("0b" . join('', reverse(@bits)));
}

my $gamma_rate = get_gamma_rate(nums_arr => \@diagnostics);
my $epsilon_rate = ~$gamma_rate & 0b111111111111;
my $power_consumption = $gamma_rate * $epsilon_rate;

say "gamma:$gamma_rate|epsilon:$epsilon_rate|power:$power_consumption";
