#!/usr/bin/perl

use strict;
use warnings;

use LWP::Simple;
binmode(STDOUT,':utf8');

my $page = get("http://bashorg.org/");

for my $el ($page =~ /class="q".+?(#\d+.*?)<\/span/sg) {
  print $el,"\n\n";
  $el =~ /#(\d*).*?\|\s(.*)\s\|.*?class="quote">(.*)<\/div>.*>(\d*)/s;
  
  print $1,"\n",$2,"\n",$3,"\n",$4,"\n\n\n";
}
