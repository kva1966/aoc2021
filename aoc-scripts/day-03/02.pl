#!/usr/bin/env perl

use 5.34.0;
use warnings;
use Function::Parameters;

use AOC::Util qw( read_input_file_to_array );

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
    my $hash = { 0 => 0, 1 => 0 };
    for my $val (@{$arr}) {
        $hash->{$val} += 1;
    }
    return $hash;
}

fun get_freq_bit(:$bits_freq_hash, :$mode = 'max', :$bit_val_if_eq_freq = 0) {
    my $zero_freq = $bits_freq_hash->{0};
    my $one_freq = $bits_freq_hash->{1};
    my $eq = $zero_freq == $one_freq;

    my $freq_val =  $mode eq 'max' ?
        ($one_freq >= $zero_freq ? 1 : 0) :
        ($one_freq <= $zero_freq ? 1 : 0);

    return $eq ? $bit_val_if_eq_freq : $freq_val;
}

fun filter_nums(:$nums_arr, :$bit_pos, :$bit_val) {
    return grep 
        { bit_at($_, $bit_pos) == $bit_val }
        @{$nums_arr};
}

fun get_bits_at_pos($nums_arr, $pos) {
    my @bits_at_pos;
    for my $num (@{$nums_arr}) {
        push @bits_at_pos, bit_at($num, $pos);
    }
    return @bits_at_pos;
}

fun filter_nums_at_pos(:$nums_arr, :$bit_pos, :$mode = 'max', :$bit_val_if_eq_freq = 0) {
    my @bits_at_pos = get_bits_at_pos($nums_arr, $bit_pos);

    my $freq_bit_val = get_freq_bit(
        bits_freq_hash => bits_freq(\@bits_at_pos),
        mode => $mode,
        bit_val_if_eq_freq => $bit_val_if_eq_freq
    );

    return filter_nums(
        nums_arr => $nums_arr,
        bit_pos => $bit_pos,
        bit_val => $freq_bit_val
    );
}

fun get_rating(:$nums_arr, :$mode = 'max', :$bit_val_if_eq_freq = 0, :$bits = 12) {
    my @current_nums = @{$nums_arr};

    for my $pos (reverse(0 .. ($bits - 1))) {
        @current_nums = filter_nums_at_pos(
            nums_arr => \@current_nums,
            bit_pos => $pos,
            mode => $mode,
            bit_val_if_eq_freq => $bit_val_if_eq_freq
        );

        if (scalar @current_nums == 1) {
            return $current_nums[0];
        }
    }

    die "Failed to converge to a single number";
}

fun get_oxygen_generator_rating(:$nums_arr) {
    return get_rating(
        nums_arr => $nums_arr,
        mode => 'max',
        bit_val_if_eq_freq => 1,
    )
}

fun get_co2_scrubber_rating(:$nums_arr) {
    return get_rating(
        nums_arr => $nums_arr,
        mode => 'min',
        bit_val_if_eq_freq => 0
    )
}

my $oxygen_gen_rating = get_oxygen_generator_rating(nums_arr => \@diagnostics);
my $co2_scrubber_rating = get_co2_scrubber_rating(nums_arr => \@diagnostics);
my $life_support_rating = $oxygen_gen_rating * $co2_scrubber_rating;

say "oxy:$oxygen_gen_rating|co2:$co2_scrubber_rating|life:$life_support_rating";
