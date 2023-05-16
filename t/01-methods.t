#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

use_ok 'Music::Percussion::Tabla';

subtest defaults => sub {
    my $obj = new_ok 'Music::Percussion::Tabla' => [
        verbose => 1,
    ];

    is $obj->verbose, 1, 'verbose';
    is $obj->soundfont, 'share/Tabla.sf2', 'soundfont';
};

done_testing();
