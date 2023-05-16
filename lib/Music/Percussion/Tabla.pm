package Music::Percussion::Tabla;

# ABSTRACT: Play the tabla!

our $VERSION = '0.0100';

use lib map { "$ENV{HOME}/sandbox/$_/lib" } qw(MIDI-Util MIDI-Drummer-Tiny);

use Moo;
use Carp qw(croak);
use MIDI::Util qw(dura_size reverse_dump);
use File::ShareDir qw(dist_dir);
use strictures 2;
use namespace::clean;

extends 'MIDI::Drummer::Tiny';

=head1 SYNOPSIS

  use Music::Percussion::Tabla ();

  my $tabla = Music::Percussion::Tabla->new;

  say $tabla->soundfont;

=head1 DESCRIPTION

A C<Music::Percussion::Tabla> is a Moo module.

=head1 ATTRIBUTES

=head2 soundfont

  $soundfont = $tabla->soundfont;

The file location, where the tabla soundfont resides.

Default: F<dist_dir()/Tabla.sf2>

=cut

has soundfont => (is => 'lazy');

sub _build_soundfont {
    my ($self) = @_;
    my $dir = eval { dist_dir('Music-Percussion-Tabla') };
    $dir ||= 'share';
    return $dir . '/Tabla.sf2';
}

=head1 METHODS

=head2 new

  $tabla = Music::Percussion::Tabla->new(%args);

Create a new C<Music::Percussion::Tabla> object.

=for Pod::Coverage BUILD

=for Pod::Coverage DEMOLISH

=cut

sub BUILD {
    my ($self, $args) = @_;
    # TODO install-enable tabla soundfont?
}

sub DEMOLISH {
    my ($self, $in_global_destruction) = @_;
    # TODO disable tabla soundfont?
}

=head2 ta

  $tabla->ta;
  $tabla->ta($tabla->sixteenth);

Daya bol: ta/na

Default note: C<71>

=cut

sub ta {
    my ($self, $dura) = @_;
    $self->_strike($dura, 71);
}

=head2 tin

  $tabla->tin;
  $tabla->tin($tabla->sixteenth);

Daya bol: tin

Default note: C<82>

=cut

sub tin {
    my ($self, $dura) = @_;
    $self->_strike($dura, 82);
}

=head2 tu

  $tabla->tu;
  $tabla->tu($tabla->sixteenth);

Daya bol: tu

Default note: C<87>

=cut

sub tu {
    my ($self, $dura) = @_;
    $self->_strike($dura, 87);
}

=head2 te

  $tabla->te;
  $tabla->te($tabla->sixteenth);

Daya bol: te

Default note: C<62>

=cut

sub te {
    my ($self, $dura) = @_;
    $self->_strike($dura, 62);
}

=head2 tete

  $tabla->tete;
  $tabla->tete($tabla->sixteenth);

Daya bol: tete

Default notes: C<te>, C<64>

=cut

sub tete {
    my ($self, $dura) = @_;
    $dura ||= $self->quarter;
    $dura = dura_size($dura) / 2;
    my $dump = reverse_dump('length');
    $self->te($dump->{$dura});
    $self->_strike($dump->{$dura}, 77);
}

=head2 ka

  $tabla->ka;
  $tabla->ka($tabla->sixteenth);

Baya bol: ka/ki/ke/kath

Default note: C<68>

=cut

sub ka {
    my ($self, $dura) = @_;
    $self->_strike($dura, 68);
}

=head2 ga

  $tabla->ga;
  $tabla->ga($tabla->sixteenth);

Baya bol: ga/gha/ge/ghe

Default note: C<63>

=cut

sub ga {
    my ($self, $dura) = @_;
    $self->_strike($dura, 63);
}

=head2 dha

  $tabla->dha;
  $tabla->dha($tabla->sixteenth);

Baya bol: dha = C<ga> + C<ta>

=cut

sub dha {
    my ($self, $dura) = @_;
    $self->_double_strike($dura, 63, 71);
}

=head2 dhin

  $tabla->dhin;
  $tabla->dhin($tabla->sixteenth);

Baya bol: dhin = C<ga> + C<tin>

=cut

sub dhin {
    my ($self, $dura) = @_;
    $self->_double_strike($dura, 63, 82);
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

L<Moo>

L<https://www.wikihow.com/Play-Tabla>

L<https://www.taalgyan.com/theory/basic-bols-on-tabla/>

L<https://gleitz.github.io/midi-js-soundfonts/Tabla/Tabla.sf2>

=cut
