use strict;
use warnings;

use Test::More;
use Data::Libra;

plan tests => 100 * 3;

my $libra = new Data::Libra();
foreach(1 .. 100){
    my $ref = $libra->scan('test_string_' . $_);
    my @keys = keys %$ref;
    ok(@keys == 1 && $keys[0] eq 'VALUE', 'default key test');
    ok($ref->{VALUE} <= 100, 'default range test(1)');
    ok($ref->{VALUE} >= 0  , 'default range test(2)');
}
