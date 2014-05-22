#!/usr/bin/perl

use strict;
use warnings;

my $filename = "ZebGene_Loci.txt";
open(FILE, $filename) || die "Can't open file $filename";
my @lines = <FILE>;

shift @lines;


my %pos_hash;
foreach(@lines)
{
	my @temp = split("\t",$_);
	my $id = shift(@temp);
	my $pos = join("\t",@temp);
	$pos_hash{$id}=$pos;
}

my $filename2 = "FL_kid_expression_nn.txt";
open(FILE, $filename2) || die "Can't open file $filename2";
my @lines2 = <FILE>;

my $output = "geneid\tchr\tleft\tright\n";
foreach(@lines2)
{
	my @temp = split("\t",$_);
	my $gene_id = $temp[0];
	#print "$gene_id\n";
	if (exists $pos_hash{$gene_id})
	{
		$output.="$gene_id\t$pos_hash{$gene_id}\n";
	}
}


open FILE, ">". "gene_position" or die $!;
print FILE $output;
close FILE;