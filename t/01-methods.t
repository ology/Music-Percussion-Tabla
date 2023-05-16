#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

use_ok 'Music::Percussion::Tabla';

my $obj = new_ok 'Music::Percussion::Tabla' => [
    verbose => 1,
];

is $obj->verbose, 1, 'verbose';

done_testing();
