use strict;
use warnings;

use Test::More;
use Data::Libra;

#===============================================================================
# Main
#===============================================================================
plan tests => 3;

eval {
    my $libra = new Data::Libra( values => {x => [10, 0xffffffff + 11]} );
};

ok($@, 'occured error');

eval {
    my $libra = new Data::Libra( values => {x => [1, 0]} );
};

ok($@, 'occured error 2');


eval {
    my $libra = new Data::Libra( values => {x => [10, 0xffffffff + 10]} );
};

ok(! $@, 'not occured error');
