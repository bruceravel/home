#!/usr/bin/perl

use strict;
use warnings;
use File::Copy;
use File::Spec;

## drop new pix into this directory, then

opendir(my $D, '.');
my @list = sort grep {$_ =~ m{jpg\z}} readdir $D;
closedir $D;

#print join($/, @list), $/;

my $date = (split(" ", $list[0]))[0];

mkdir($date) if (not -d $date);

foreach my $f (@list) {
  (my $target = $f) =~ s{$date }{};
  move($f, File::Spec->catfile($date, $target));
};

## cd into $date directory and do:
## for f in `ls`; do convert -geometry 10% $f sm_$f; done
