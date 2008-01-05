use strict;
use warnings;

use Test::More;
use Data::Libra;

#===============================================================================
# constant variebles
#===============================================================================
my $_repeat_test = 250;
my @_words = qw(hogehoge hagehoge hogehage hagehage);
my $_dispersion = 25;
my $_success_rate_min = 50; # the expected value is about 70% on the average

#===============================================================================
# Main
#===============================================================================
require 't/util.pl';

plan tests => (@_words - 1 + 2) * $_repeat_test + 1;

my $ok_cnt = 0;
foreach (1 .. $_repeat_test) {
    # initialize for tests
    my $libra = new Data::Libra(
        salt   => $_, 
        values => {X => [0, 100]},
    );

    my @stats = ();
    foreach ( @_words ) {
        my $stat = $libra->scan($_);
        push(@stats, $stat);
    }

    # start tests
    my $is_distance_allok = 1;
    foreach my $i (1 .. $#_words) {
        ok(has_same_keys($stats[0], $stats[$i]), 
           "does values of $i have same keys");
        # We are expecting random numbers to be generated. 
        # so the distance between the values is more than a certain value.
        $is_distance_allok = 0 
            if distance($stats[0], $stats[$i]) <= $_dispersion;
    }

    # will get same values from same string
    my $stat0_2 = $libra->scan($_words[0]);
    ok(has_same_keys($stat0_2, $stats[0]), 'same string, same keys');
    is(distance($stat0_2, $stats[0]), 0, 'same string, same stat');

    # distance check (this test contain random factor. so trying many times.)
    $ok_cnt++ if $is_distance_allok;
}

# We repeated this test. Therefore, it should be sure not to fail.
my $success_rate = int($ok_cnt * 100 / $_repeat_test);
warn "# success rate of random test = $success_rate%" . 
     " (more than $_success_rate_min% is OK)\n";
ok($success_rate > $_success_rate_min, 
   "is the total of distance enough long ?");
