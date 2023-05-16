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
    is $obj->channel, 0, 'channel';
    diag 'Soundfont file: ', $obj->soundfont;
    like $obj->soundfont, qr/\/Tabla\.sf2$/, 'soundfont';
};

subtest timidity_conf => sub {
    my $obj = new_ok 'Music::Percussion::Tabla';
    like $obj->timidity_conf, qr/\/Tabla\.sf2$/, 'timidity_conf';
    my $filename = './timidity_conf';
    $obj->timidity_conf($filename);
    ok -e $filename, 'timidity_conf with filename';
    unlink $filename;# or diag "Can't unlink $filename: $!";
    ok !-e $filename, 'file unlinked';
};

done_testing();
