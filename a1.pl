#!/usr/bin/perl

use strict;
use warnings;

use LWP::Simple;
use utf8;
binmode(STDOUT,':utf8');

use DBI;
use JSON;

my $db = DBI->connect("dbi:SQLite:dbname=bashorg.db","","");
my $page = get("http://bashorg.org/");
my @res_out;

for my $el ($page =~ /class="q".+?(#\d+.*?)<\/span/sg) {
  $el =~ /#(\d*).*?\|\s(.*)\s\|.*?class="quote">(.*)<\/div>.*>(-?\d*)/s;
  
  $db->do("
    INSERT INTO quotes (number,date,content,rating)
    VALUES (?,?,?,?)",
    undef,$1,$2,$3,$4
  );

  push @res_out,{
    number=>$1,
    text=>$3,
  };
}
print JSON->new->encode(\@res_out);
