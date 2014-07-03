use warnings;
use strict;
use Test::More qw( no_plan );

do 'cnv_pos.pl';

is (parse('chr9:16,634,605-16,676,533		2	2	2	2	2	2	2	2	2	3	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2'),"chr9:16,634,605-16,676,533\t9\t16655569\n");
