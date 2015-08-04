#!/usr/bin/perl
use strict;
use warnings;

my $snp_output = "id\tchr\tposition\n";
my $gene_output = "id\tchr\tstart\tend\n";

my $input_file = "data/new_miRNA_positions";

open(FILE,$input_file) || die "Can't open file $input_file.\n";
while(<FILE>)
{
	chomp;
    my @temp = split "\t",$_;
	$temp[0]=~s/chr//;

	my $snp_pos = ($temp[1]+$temp[2])/2;
	$snp_output.="$temp[3]\t$temp[0]\t$snp_pos\n";
	$gene_output.="$temp[3]\t$temp[0]\t$temp[1]\t$temp[2]\n";
}
close FILE;

open FILE, ">". "miRNA_positions.snps" or die $!;
print FILE $snp_output;
close FILE;

open FILE, ">" . "miRNA_positions.gene" or die $!;
print FILE $gene_output;
close FILE;
