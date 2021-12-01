package AOC::Util;

use 5.34.0;
use warnings;

use Function::Parameters qw( :strict );
use Readonly;

use Exporter 'import';
our @EXPORT_OK = qw( 
    read_input_file_to_array
);

Readonly my $INPUT_DIR => "./datafiles/inputs";

fun read_input_file_to_array($filename) {
    my $path = "$INPUT_DIR/$filename";
    my @lines;

    if (open my $fh, '<:encoding(utf8)', "$path") {
        chomp(@lines = <$fh>);
        close $fh;
    }

    return @lines;
}


1;
