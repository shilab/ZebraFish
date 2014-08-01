use warnings;
use strict;
use Test::More qw( no_plan );

do 'cnv.pl';

my @expected = ("chr20:420,249-490,253", "Tu20-1\t");
my @got = parse('Tu20_US85003610_252535510051_S01_CGH_105_Jan09_1_1	chr20:420,249-490,253	CN Loss	70005		0.0	-0.9277717173099518		20');

is_deeply(\@got,\@expected);

@expected = ("chr20:420,249-490,253", "Tu20-3\t");
@got = parse('Tu20_US85003610_252535510051_S01_CGH_105_Jan09_1_1	chr20:420,249-490,253	CN Gain	70005		0.0	-0.9277717173099518		20');

is_deeply(\@got,\@expected);

@expected = ("chr20:420,249-490,253", "Tu20-0\t");
@got = parse('Tu20_US85003610_252535510051_S01_CGH_105_Jan09_1_1	chr20:420,249-490,253	Homozygous Copy Loss	70005		0.0	-0.9277717173099518		20');

is_deeply(\@got,\@expected);

@expected = ("chr20:420,249-490,253", "Tu20-4\t");
@got = parse('Tu20_US85003610_252535510051_S01_CGH_105_Jan09_1_1	chr20:420,249-490,253	High Copy Gain	70005		0.0	-0.9277717173099518		20');

is_deeply(\@got,\@expected);

@expected = ('',);
@got = parse_keys('\n');

is_deeply(\@got,\@expected);

@expected = ("chr9:16,634,605-16,676,533","2	2	2	2	2	2	2	2	2	3	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2\t");
@got = parse_keys('chr9:16,634,605-16,676,533');

is_deeply(\@got,\@expected);

