#!/usr/bin/env perl

use 5.34.0;
use warnings;

use Function::Parameters;
use Furl;
use Readonly;

fun usage() {
    say "Usage: $0 <url> <output-file>"
}

if ($#ARGV < 1) {
    usage;
    exit 1;
}

Readonly my $OUTPUT_DIR => 'datafiles';

my ($url, $output_file) = @ARGV;

my $response = Furl->new->get($url);

die "Failed: " . $response->code . " " . $response->message
    unless $response->code == 200;

my $body = $response->content;
my $filename = "$OUTPUT_DIR/$output_file";

open(my $fh, '>', $filename)
    or die "Could not open file [$filename]: $!";
print $fh $body if length($body);
close $fh;
say "Wrote[$url] content to [$filename]";
