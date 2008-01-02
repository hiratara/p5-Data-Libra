use strict;
use warnings;

use Test::More tests => 7;

# tests for tests ... is this bad :-p ??
require 't/util.pl';

ok(has_same_keys({a => 1, b => 2}, {a => 3, b => 4}), 'same key');
ok(! has_same_keys({a => 1, b => 2}, {a => 3}), 'other keys 1');
ok(! has_same_keys({b => 2}, {a => 3, b => 4}), 'other keys 2');
ok(! has_same_keys({a => 1, b => 2}, {b => 3, c => 4}), 'other keys 3');

is(distance({x => 1}, {x => 2}), 1, 'check distance of 1 dimension');
is(distance({x => 1, y => 3}, {x => 2, y => 2}), 2, 
   'check distance of 2 dimension');
is(distance({x => 1, y => 3, z => 10}, {x => 2, y => 2, z => 8}), 
   6, 'check distance of 3 dimension');

