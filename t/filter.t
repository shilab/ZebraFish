use warnings;
use strict;
use Test::More qw( no_plan );

local @ARGV=qw( CNV_matrix.out 0.05 );
do 'filter.pl';

is (parse('id	F0M	Tu57	Tu21	Tu42	Tu41	Tu53	Tu52	Tu50	Tu43	Tu2	Tu6	Tu49	Tu46	Tu58	Tu48	Tu45	Tu54	Tu56	Tu34	Tu47	Tu55	Tu27	Tu44	Tu36	Tu38'), "id	F0M	Tu57	Tu21	Tu42	Tu41	Tu53	Tu52	Tu50	Tu43	Tu2	Tu6	Tu49	Tu46	Tu58	Tu48	Tu45	Tu54	Tu56	Tu34	Tu47	Tu55	Tu27	Tu44	Tu36	Tu38\n", 'header test');

is (parse('chr9:16,634,605-16,676,533   2       2       2       2       2       2       2       2       2       2       2       2       2       2       2       2       2       2       2       2'), '','All the same genotype');

is (parse('chr9:16,634,605-16,676,533	2	2	2	2	2	2	2	2	3	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2'), '', 'One sample different');
my @output = parse('chr18:45,085,698-45,098,051	2	2	2	2	2	2	2	2	2	2	4	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	4	4'); #, "chr18:45,085,698-45,098,051	0.1\n", 'Three samples different');
my @expected = ("chr18:45,085,698-45,098,051	2	2	2	2	2	2	2	2	2	2	4	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	4	4\n", "chr18:45,085,698-45,098,051	0.1\n");

is_deeply (\@output,\@expected,'array test');

is (parse('chr9:16,634,605-16,676,533	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	3	2	2	2	2	2	2	2	2	2	4'), '', 'Two samples different, with different genotypes');
