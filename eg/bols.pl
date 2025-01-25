#!/usr/bin/env perl
use strict;
use warnings;

use Music::Percussion::Tabla ();

my $bpm = shift || 100;
my $max = shift || 4;

my $t = Music::Percussion::Tabla->new(
    file   => "$0.mid",
    bpm    => $bpm,
    volume => 127,
);

for (1 .. $max) {
    $t->strike('tin');
    # $t->note($t->quarter, 60); # tin
    # $t->note($t->quarter, 63); # tin
    # $t->note($t->quarter, 83); # tin muted
    # $t->note($t->quarter, 87); # tin muted
    # $t->note($t->quarter, 61); # ti
    # $t->note($t->quarter, 68); # ti muted
    # $t->note($t->quarter, 70); # ti muted
    # $t->note($t->quarter, 72); # ti muted quiet
    # $t->note($t->quarter, 82); # ti muted loud
    # $t->note($t->quarter, 86); # ti muted
    # $t->note($t->quarter, 64); # ke quiet
    # $t->note($t->quarter, 77); # ke
    # $t->note($t->quarter, 79); # ke
    # $t->note($t->quarter, 65); # ge
    # $t->note($t->quarter, 66); # ge
    # $t->note($t->quarter, 76); # ge
    # $t->note($t->quarter, 67); # dhun
    # $t->note($t->quarter, 80); # dhun
    # $t->note($t->quarter, 71); # ta
    # $t->note($t->quarter, 75); # ta
    # $t->note($t->quarter, 85); # ta
    # $t->note($t->quarter, 88); # ta ringing
    # $t->note($t->quarter, 73); # tun
    # $t->note($t->quarter, 78); # na
    # $t->note($t->quarter, 81); # na muted
    # $t->note($t->quarter, 62); # ?
    # $t->note($t->quarter, 69); # ?
    # $t->note($t->quarter, 74); # ? quiet
    # $t->note($t->quarter, 84); # ?
}

$t->play_with_timidity;
