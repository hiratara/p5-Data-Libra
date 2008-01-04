use strict;
use warnings;

use Test::More;
use Data::Libra;

require 't/util.pl';
plan tests => 4;

# test 1
{
    my $libra = new Data::Libra( values => {x => [-1, 2]} );

    my %ret = ();
    foreach (0 .. 100_000) {
	my $stat = $libra->scan($_);
	$ret{ $stat->{x} } = 1 if defined $stat->{x};
    }

    # All numbers are likely to be found.
    ok($ret{-1} && $ret{0} && $ret{1} && $ret{2}, 'values range check');
}


# test 2
{
    my $libra = new Data::Libra(
				values => {
					   x => [0, 1], 
					   y => [0, 1], 
					   z => [0, 1], 
					  } );
    my $stat = $libra->scan('hoge');
    ok(has_same_keys($stat, {x => 0, y => 0, z => 1}), 'values keys check');
}


# test 3, 4
{
    my $libra1 = new Data::Libra( 
        salt => '1', values => {x => [0, 0xFFFFFFFF]
    });
    my $libra2 = new Data::Libra( 
        salt => '2', values => {x => [0, 0xFFFFFFFF]
    });
    my $libra3 = new Data::Libra( 
        salt => '1', values => {x => [0, 0xFFFFFFFF]
    });
    my $stat1 = $libra1->scan('foofoo');
    my $stat2 = $libra2->scan('foofoo');
    my $stat3 = $libra3->scan('foofoo');
    ok($stat1->{x} != $stat2->{x}, 'different salt, different values');
    ok($stat1->{x} == $stat3->{x}, 'same salt, same values');
}
