package WWW::Shorten::TK;

=head1 NAME

WWW::Shorten::TK - Perl interface to tweak.tk

=head1 SYNOPSIS

  use WWW::Shorten::TK;
  use WWW::Shorten 'TK';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

C<WWW::Shorten::TK> is one of the many C<WWW::Shorten> subclasses that
provide a Perl interface to a URL-shortening service. This module provides
access to the free service hosted at tweak.tk.

=cut

use strict;
use warnings;
use Carp;

use base qw/WWW::Shorten::generic Exporter/;

our @EXPORT  = qw/makeashorterlink makealongerlink/;
our $VERSION = '0.01';
our $ERROR   = undef;

=head1 EXPORTS

=head2 makeashorterlink(C<long_url>)

Returns the shortened version of C<long_url> or C<undef> on failure.

=cut

sub makeashorterlink ($)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $ua  = __PACKAGE__->ua();

    my $res = $ua->get("http://api.dot.tk/tweak/shorten?long=$url");
    if ($res->code == 200) {
        if ($res->content =~ m!^(http://\w+\.tk)!) {
            $1 =~ s/(\s+)$//;
            return $1;
        }
    }
    else {
        $ERROR = $res->content;
    }

    return undef;
}

=head2 makealongerlink(C<short_url>)

Returns the full version of C<short_url> or C<undef> on failure.

=cut

sub makealongerlink ($)
{
    my $url = shift or croak 'No URL passed to makealongerlink';
    my $ua  = __PACKAGE__->ua();

    # really, I should leave this logic to the user
    return undef unless ($url =~ m!^http://\w+\.tk!i);

    my $res = $ua->get("http://api.dot.tk/tweak/lengthen?shortname=$url");
    unless ($res->code == 200) {
        $ERROR = $res->content;
        return $res->code;
    }

    my $longurl = $res->content;
    $longurl =~ s/(\s+)$//;

    return $longurl;
}

1;

__END__

=head1 SEE ALSO

=over 4

=item * L<WWW::Shorten>

=item * L<http://tweak.tk/>

=back

=head1 AUTHOR

Björn Andersson <ba@sanitarium.se>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 Björn Andersson

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
