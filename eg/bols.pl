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
    $t->note($t->quarter, 60);
    $t->note($t->quarter, 63);
    $t->note($t->quarter, 83);
    $t->note($t->quarter, 87);
}

$t->play_with_timidity;

__END__
60 = tin
61 = ti
62 = 
63 = tin
64 = ke
65 = ge
66 = ge
67 = dhun
68 = ti
69 = 
70 = ti
71 = ta
72 = ti
73 = tun
74 = 
75 = ta
76 = ge
77 = ke
78 = na
79 = ke
80 = 
81 = na
82 = ti
83 = tin
84 = 
85 = ta
86 = ti
87 = tin
88 = ta

$t->tun;
$t->rest($t->quarter);
$t->ta;
$t->tun;
$t->tin;
$t->tin;
$t->tun;
$t->ta;
$t->te;
$t->te;
$t->ta;
$t->tun;
$t->ta;
$t->tun;
$t->ta;
$t->tun;
$t->tun;
$t->tin;
$t->tin;
$t->ta;
$t->ta;
$t->rest($t->whole);

$t->ta;
$t->tun;
$t->tun;
$t->ta;
$t->ta;
$t->tun;
$t->tun;
$t->ta;
$t->ta;
$t->te;
$t->te;
$t->ta;
$t->ta;
$t->tin;
$t->tin;
$t->ta;
$t->rest($t->whole);

$t->ga;
$t->te;
$t->ka;
$t->ga;
$t->rest($t->quarter);
$t->ka;
$t->ta;
$t->rest($t->quarter);
$t->ta;
$t->ga;
$t->ta;
$t->ka;
$t->ta;
$t->ka;
$t->tu;
$t->ta;
$t->ta;
$t->ga;
$t->ta;
$t->tin;
$t->ta;
$t->ka;
$t->ga;
$t->te;
$t->ta;
$t->rest($t->whole);

for my $i (1 .. 3) {
    $t->ta;
    $t->ta;
    $t->tun;
    $t->ga;
    $t->rest($t->quarter);
}

$t->play_with_timidity;
