#!/usr/bin/perl

use Test::More tests => 1;
use WWW::Shorten::TK;
use WWW::Shorten 'TK';

my $short = makeashorterlink(
 'http://piratpartiet.se/'
);

my $long = makealongerlink(
  $short
);

is('http://piratpartiet.se/', $long);
