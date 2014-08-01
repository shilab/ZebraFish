#!/usr/bin/perl
use warnings;
use strict;
use Test::More qw( no_plan );

do 'miRNA_pos.pl';

print "Case A: 14qII-4_x_st\n";
my @got_caseA_1 = parse_one('14qII-4_x_st	miRNA-2_0	Homo sapiens	8-Oct-10	CDBox	Affymetrix Proprietary Database	14qII-4	chr14:101420711-101420784 (+)	74	TGAGCCAGTGATGAAAACTGGTGGCATAGAAGTCAAGGATGCTGAATAATGTGTGTCTAGAACTCTGAGGTTCA
');
my @expect_caseA_1 = ("14qII-4_x_st","chr14:101420711-101420784 (+)");

is_deeply(\@got_caseA_1,\@expect_caseA_1);

my $caseA_2 = join("\t",@expect_caseA_1);

my $got_caseA_2 = parse_two($caseA_2);

is($got_caseA_2,"14qII-4_x_st\tchr14:101420711-101420784 (+)");

# if ok:
my $got_caseA_3 = $got_caseA_2;
is(parse_three($got_caseA_3),"14qII-4_x_st\t14\t101420747.5\n");

print "Case A was sucessfully taken out its positions and chromosome number.\n\n";

#--------------------------------------------------------------------------------------------------------------------

print "Case B: hp_mmu-mir-466b-1_x_st. this id have 6 aligmnents which seperated by '\\', and we just need first alignment\n";
my @got_caseB_1 = parse_one('hp_mmu-mir-466b-1_x_st	miRNA-2_0	Mus musculus	8-Oct-10	stem-loop	Affymetrix Proprietary Database	mmu-mir-466b-1 // mmu-mir-466b-1 // mmu-mir-466b-1 // mmu-mir-466b-1 // mmu-mir-466b-1 // mmu-mir-466b-1	2:10395846-10395927 (+) // 2:10408054-10408135 (+) // 2:10410516-10410597 (+) // 2:10415429-10415510 (+) // 2:10417897-10417978 (+) // 2:10422740-10422821 (+)	82	TGTATGTGTTGATGTGTGTGTACATGTACATGTGTGAATATGATATACATATACATACACGCACACATAAGACACATATGAG
');
my @expect_caseB_1 = ("hp_mmu-mir-466b-1_x_st","2:10395846-10395927 (+) // 2:10408054-10408135 (+) // 2:10410516-10410597 (+) // 2:10415429-10415510 (+) // 2:10417897-10417978 (+) // 2:10422740-10422821 (+)");

is_deeply(\@got_caseB_1,\@expect_caseB_1);

my $caseB_2 = join("\t",@expect_caseB_1);

my $got_caseB_2 = parse_two($caseB_2);

is($got_caseB_2,"hp_mmu-mir-466b-1_x_st\t2:10395846-10395927 (+) \n");

# if ok:
my $got_caseB_3 = $got_caseB_2;
is(parse_three($got_caseB_3),"hp_mmu-mir-466b-1_x_st\t2\t10395886.5\n");

print "Case B was sucessfully taken out its positions and chromosome number.\n\n";

#--------------------------------------------------------------------------------------------------------------------

print "Case C: dwi-miR-92a_st\n";
my @got_caseC_1 = parse_one('dwi-miR-92a_st	miRNA-2_0	Drosophila willistoni	8-Oct-10	miRNA	Affymetrix Proprietary Database	dwi-mir-92a	scf2_1100000004943:14578432-14578512 (-)	22	CAUUGCACUUGUCCCGGCCUAU
');
my @expect_caseC_1 = ("dwi-miR-92a_st","scf2_1100000004943:14578432-14578512 (-)");

is_deeply(\@got_caseC_1,\@expect_caseC_1);

my $caseC_2 = join("\t",@expect_caseC_1);

my $got_caseC_2 = parse_two($caseC_2);

is($got_caseC_2," ","Blank comes out, it can't pass this level");

print "Case C was not sucessfully taken out its positions and chromosome number.\n";
