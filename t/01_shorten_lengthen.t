#!/usr/bin/perl

use Test::More tests => 1;
use WWW::Shorten::TK;
use WWW::Shorten 'TK';

my $url = 'http://maps.google.se/maps?f=q&source=s_q&hl=sv&geocode=&q=djupr%C3%B6ra&sll=62.404546,17.259125&sspn=0.010934,0.030341&ie=UTF8&hq=&hnear=Djupr%C3%B6ra&z=13';

my $short = makeashorterlink(
 $url
);

my $long = makealongerlink(
  $short
);

is($url, $long);
