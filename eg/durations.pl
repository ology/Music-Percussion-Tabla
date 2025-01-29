#!/usr/bin/env perl
use strict;
use warnings;

use Music::Duration::Partition ();
use Music::Percussion::Tabla ();

my $bpm  = shift || 120;
my $bars = shift || 8;
my $size = shift || 5;

my $mdp = Music::Duration::Partition->new(
  size    => $size,
  pool    => [qw(qn den en dsn sn)],
  weights => [qw( 2   1  2   1  2)],
  groups  => [qw( 1   1  2   1  2)],
);

my $motif = $mdp->motif;

my $t = Music::Percussion::Tabla->new(
  bpm    => $bpm,
  bars   => $bars,
  reverb => 8,
);

my @bols = keys $t->patches->%*;

for my $i (1 .. $t->bars) {
  for my $dura (@$motif) {
    my $bol = $bols[ int rand @bols ];
    $t->strike($bol, $dura);
  }
  $t->rest($t->quarter) unless $i == $t->bars;
}

$t->play_with_timidity;
