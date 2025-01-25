package Music::Percussion::Tabla;

# ABSTRACT: Play the tabla!

our $VERSION = '0.0200';

use Moo;
use File::Slurper qw(write_text);
use MIDI::Util qw(dura_size reverse_dump);
use File::ShareDir qw(dist_dir);
use strictures 2;
use namespace::clean;

extends 'MIDI::Drummer::Tiny';

=head1 SYNOPSIS

  use Music::Percussion::Tabla ();

  my $t = Music::Percussion::Tabla->new;

  $t->timidity_cfg('/tmp/timidity.cfg'); # optional

  say $t->soundfont;

  for my $i (1 .. 3) {
    $t->ta($t->eighth);
    $t->ta($t->eighth);
    $t->tun($t->quarter);
    $t->ga($t->quarter);
    $t->rest($t->quarter);
  }

  $t->play_with_timidity;
  # OR:
  $t->write; # save the score as a MIDI file

=head1 DESCRIPTION

C<Music::Percussion::Tabla> provides named associations between tabla
drum sounds and the included soundfont file (which is B<4.1MB>).

Here are my "non-tabla player" descriptions of the sounds:

   # MIDI Bol  - Description
  ...
   1 60   tin  - ringing mid
   2 61   ti   - muted low
   3 62   ?    - slap
   4 63   tin  - ringing mid slap
   5 64   ke   - low knock
   6 65   ge   - muted ringing low
   7 66   ge   - lower
   8 67   dhun - low-up
   9 68   ti   - muted slap
  10 69   ?    - ringing low
  11 70   ti   - flam slap
  12 71   ta   - loud tap
  13 72   ti   - lowest mute
  14 73   tun  - ringing low
  15 74   ?    - muted low
  16 75   ta   - loud tap double
  17 76   ge   - high-low
  18 77   ke   - high slap
  19 78   na   - tap
  20 79   ?    - high knock
  21 80   dhun - short low-up
  22 81   na   - mid tap
  23 82   ti   - muted tap
  24 83   tin  - mid
  25 84   ?    - muted
  26 85   ta   - loud mid double
  27 86   ti   - slightly more muted
  28 87   tin  - low mid
  29 88   ta   - ringing mid
  ...

To play patches by number, do this to add to the C<84>th MIDInum entry
score:

  $tabla->note($tabla->eighth, 79);

To play patches simultaneously, that would be:

  $tabla->note($tabla->eighth, 79, 87);

=head1 ATTRIBUTES

=head2 soundfont

  $soundfont = $tabla->soundfont;

The file location, where the tabla soundfont resides.

Default: F<dist_dir()/Tabla.sf2>

=cut

has soundfont => (
    is      => 'ro',
    builder => 1,
);

sub _build_soundfont {
    my ($self) = @_;
    my $dir = eval { dist_dir('Music-Percussion-Tabla') };
    $dir ||= 'share';
    return $dir . '/Tabla.sf2';
}

=head1 METHODS

=head2 new

  $tabla = Music::Percussion::Tabla->new(%args);

Create a new C<Music::Percussion::Tabla> object. This uses all the
possible properties of L<MIDI::Drummer::Tiny>.

=for Pod::Coverage BUILD

=cut

sub BUILD {
    my ($self, $args) = @_;
    $self->set_channel(0);
}

=head2 tun

  $tabla->tun;
  $tabla->tun($tabla->sixteenth);

Daya bol: tun

=cut

sub tun {
    my ($self, $dura) = @_;
    $self->_strike($dura, $self->tun_num);
}

=head2 ta

  $tabla->ta;
  $tabla->ta($tabla->sixteenth);

Daya bol: ta/na

=cut

sub ta {
    my ($self, $dura) = @_;
    $self->_strike($dura, $self->ta_num);
}

=head2 tin

  $tabla->tin;
  $tabla->tin($tabla->sixteenth);

Daya bol: tin

=cut

sub tin {
    my ($self, $dura) = @_;
    $self->_strike($dura, $self->tin_num);
}

=head2 tu

  $tabla->tu;
  $tabla->tu($tabla->sixteenth);

Daya bol: tu

=cut

sub tu {
    my ($self, $dura) = @_;
    $self->_strike($dura, $self->tu_num);
}

=head2 te

  $tabla->te;
  $tabla->te($tabla->sixteenth);

Daya bol: te

=cut

sub te {
    my ($self, $dura) = @_;
    $self->_strike($dura, $self->te_num);
}

=head2 tete

  $tabla->tete;
  $tabla->tete($tabla->sixteenth);

Daya bol: tete = C<te> + C<tete_num>

=cut

sub tete {
    my ($self, $dura) = @_;
    $dura ||= $self->quarter;
    $dura = dura_size($dura) / 2;
    my $dump = reverse_dump('length');
    $self->te($dump->{$dura});
    $self->_strike($dump->{$dura}, $self->tete_num);
}

=head2 ka

  $tabla->ka;
  $tabla->ka($tabla->sixteenth);

Baya bol: ka/ki/ke/kath

=cut

sub ka {
    my ($self, $dura) = @_;
    $self->_strike($dura, $self->ka_num);
}

=head2 ga

  $tabla->ga;
  $tabla->ga($tabla->sixteenth);

Baya bol: ga/gha/ge/ghe

=cut

sub ga {
    my ($self, $dura) = @_;
    $self->_strike($dura, $self->ga_num);
}

=head2 ga_slide

  $tabla->ga_slide;
  $tabla->ga_slide($tabla->sixteenth);

Baya bol: ga/gha/ge/ghe with wrist slide to syahi

=cut

sub ga_slide {
    my ($self, $dura) = @_;
    $self->_strike($dura, $self->ga_slide_num);
}

=head2 dha

  $tabla->dha;
  $tabla->dha($tabla->sixteenth);

Baya bol: dha = C<ga> + C<ta>

=cut

sub dha {
    my ($self, $dura) = @_;
    $self->_double_strike($dura, $self->ga_num, $self->ta_num);
}

=head2 dhin

  $tabla->dhin;
  $tabla->dhin($tabla->sixteenth);

Baya bol: dhin = C<ga> + C<tin>

=cut

sub dhin {
    my ($self, $dura) = @_;
    $self->_double_strike($dura, $self->ga_num, $self->tin_num);
}

=head2 tirkit

  $tabla->tirkit;
  $tabla->tirkit($tabla->sixteenth);

Baya bol: tirkit = C<tete> + C<ka> + C<te>

=cut

sub tirkit {
    my ($self, $dura) = @_;
    $dura ||= $self->quarter;
    $dura = dura_size($dura) / 2;
    my $dura2 = $dura / 2;
    my $dump = reverse_dump('length');
    $self->tete($dump->{$dura});
    $self->ka($dump->{$dura2});
    $self->te($dump->{$dura2});
}

sub _strike {
    my ($self, $dura, $pitch) = @_;
    $dura  ||= $self->quarter;
    $pitch ||= 60;
    $self->note($dura, $pitch);
}

sub _double_strike {
    my ($self, $dura, $pitch1, $pitch2) = @_;
    $dura   ||= $self->quarter;
    $pitch1 ||= 60;
    $pitch2 ||= 61;
    $self->note($dura, $pitch1, $pitch2);
}

1;
__END__

=head1 SEE ALSO

L<File::Slurper>

L<MIDI::Util>

L<Moo>

L<File::ShareDir>

L<https://gleitz.github.io/midi-js-soundfonts/Tabla/Tabla.sf2>

L<https://www.wikihow.com/Play-Tabla>

L<https://www.taalgyan.com/theory/basic-bols-on-tabla/>

L<https://kksongs.org/tabla/chapter02.html> &
L<https://kksongs.org/tabla/chapter03.html>

=cut
