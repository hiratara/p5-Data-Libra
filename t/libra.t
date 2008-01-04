use strict;
use warnings;

use Test::More;
use Data::Libra;

#===============================================================================
# constant variebles
#===============================================================================
my @_words = qw(hogehoge hagehoge hogehage hagehage);
my $_dispersion = 4;

#===============================================================================
# Main
#===============================================================================
require 't/util.pl';

plan tests => (@_words - 1) * 2 + 2;

# initialize for main tests
my $libra = new Data::Libra();

my @stats = ();
foreach( @_words ){
    my $stat = $libra->scan($_);
    # use Data::Dumper;
    # warn Dumper($stat);
    push(@stats, $stat);
}

# start main tests
foreach my $i(1 .. $#_words){
    ok(has_same_keys($stats[0], $stats[$i]), 
       "does values of $i have same keys");
    ok(distance($stats[0], $stats[$i]) > $_dispersion, 
       "is distance of $i enough long");
}

# will get same values from same string
my $stat0_2 = $libra->scan($_words[0]);
ok(has_same_keys($stat0_2, $stats[0]), 'same string, same keys');
is(distance($stat0_2, $stats[0]), 0, 'same string, same stat');
