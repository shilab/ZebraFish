#!/usr/bin/perl
use strict;
use warnings;


my $output = "gene_id\tchr\tleft\tright\n"; 
my $filename = "ZebGene-1_1-st-v1.r4.f38.design.transcript.design-time.pre-release.20110822.csv";
open(FILE, $filename) || die "Can't open file $filename";

while (<FILE>)
{
	chomp;
	if ($_=~/^\"\d/)
	{
		my @line = split(",",$_);
		my $probeid = substr($line[1],1,-1);
		my $chr = substr($line[2],1,-1);
		my $start = substr($line[4],1,-1);
		my $stop = substr($line[5],1,-1);

		if ($chr =~/^chr\d/)
		{
			$chr = substr($chr, 3);
			$output.= "$probeid\t$chr\t$start\t$stop\n";
		}
	}
}

open FILE,">"."gene_position" or die $!;
print FILE $output;
close FILE;